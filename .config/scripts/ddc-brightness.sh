#!/usr/bin/env bash
set -euo pipefail

readonly STEP=10
readonly BUS=6
readonly VCP=10
readonly DELAY=0.5
readonly RESTORE_DELAY=3

readonly CACHE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/last_brightness"
readonly STATE_DIR="${XDG_RUNTIME_DIR:-/run/user/$UID}/ddc-brightness"
readonly STATE_LOCK="$STATE_DIR/state.lock"
readonly APPLY_LOCK="$STATE_DIR/apply.lock"
readonly REQUEST_FILE="$STATE_DIR/latest-request"

case "${1-}" in
    up|down|restore) ;;
    *)
        printf 'Usage: %s {up|down|restore}\n' "$0" >&2
        exit 2
        ;;
esac

mkdir -p "$(dirname "$CACHE_FILE")" "$STATE_DIR"

# Read the cached brightness, falling back to the monitor if needed.
# The caller must hold STATE_LOCK.
read_brightness() {
    local value=""

    if [[ -r "$CACHE_FILE" ]]; then
        IFS= read -r value < "$CACHE_FILE" || true
    fi

    if [[ ! "$value" =~ ^[0-9]{1,3}$ ]] ||
       (( 10#$value > 100 )); then
        if ! value="$(ddcutil getvcp "$VCP" -t --bus "$BUS" |
            awk '{print $4}')"; then
            echo "Failed to read monitor brightness" >&2
            return 1
        fi
    fi

    if [[ ! "$value" =~ ^[0-9]{1,3}$ ]] ||
       (( 10#$value > 100 )); then
        echo "Invalid brightness value: $value" >&2
        return 1
    fi

    value=$((10#$value))
    printf '%s\n' "$value" > "$CACHE_FILE"
    printf '%s' "$value"
}

# Restore brightness after login or resume from sleep.
if [[ "$1" == restore ]]; then
    sleep "$RESTORE_DELAY"

    # Serialize hardware writes, then read the latest cached value.
    exec 8>"$APPLY_LOCK"
    flock 8
    exec 9>"$STATE_LOCK"
    flock 9

    CURRENT="$(read_brightness)"
    flock -u 9

    ddcutil --disable-dynamic-sleep --noverify \
        setvcp "$VCP" "$CURRENT" --bus "$BUS"

    # Refresh Waybar if it is running.
    pkill -RTMIN+8 waybar || true
    exit 0
fi

# Serialize cache updates so rapid key presses cannot lose steps.
exec 9>"$STATE_LOCK"
flock 9

CURRENT="$(read_brightness)"

if [[ "$1" == up ]]; then
    NEW=$((CURRENT + STEP))
    if (( NEW > 100 )); then NEW=100; fi
else
    NEW=$((CURRENT - STEP))
    if (( NEW < 0 )); then NEW=0; fi
fi

printf '%s\n' "$NEW" > "$CACHE_FILE"

# Mark this as the latest request.
REQUEST_ID="$$-$(date +%s%N)"
printf '%s\n' "$REQUEST_ID" > "$REQUEST_FILE.$$"
mv -f "$REQUEST_FILE.$$" "$REQUEST_FILE"

flock -u 9

notify-send "Brightness" "$NEW" \
    -h string:x-canonical-private-synchronous:osd || true

pkill -RTMIN+8 waybar || true

# Debounce repeated key presses.
sleep "$DELAY"

# Serialize hardware writes and skip superseded requests.
exec 8>"$APPLY_LOCK"
flock 8

if [[ ! -r "$REQUEST_FILE" ]] ||
   [[ "$(cat "$REQUEST_FILE")" != "$REQUEST_ID" ]]; then
    exit 0
fi

ddcutil setvcp "$VCP" "$NEW" --bus "$BUS" --noverify

