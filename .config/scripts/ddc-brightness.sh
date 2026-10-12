#!/usr/bin/env bash
set -euo pipefail

readonly STEP=10
readonly BUS=6
readonly VCP=10
readonly DELAY=0.5

readonly CACHE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/last_brightness"
readonly STATE_DIR="${XDG_RUNTIME_DIR:-/run/user/$UID}/ddc-brightness"
readonly STATE_LOCK="$STATE_DIR/state.lock"
readonly APPLY_LOCK="$STATE_DIR/apply.lock"
readonly REQUEST_FILE="$STATE_DIR/latest-request"

case "${1-}" in
    up|down) ;;
    *)
        printf 'Usage: %s {up|down}\n' "$0" >&2
        exit 2
        ;;
esac

mkdir -p "$(dirname "$CACHE_FILE")" "$STATE_DIR"

# Serialize cache updates so rapid key presses cannot lose steps.
exec 9>"$STATE_LOCK"
flock 9

CURRENT=""
if [[ -r "$CACHE_FILE" ]]; then
    IFS= read -r CURRENT < "$CACHE_FILE" || true
fi

# Read hardware brightness if the cache is missing or invalid.
if [[ ! "$CURRENT" =~ ^[0-9]{1,3}$ ]] || (( 10#$CURRENT > 100 )); then
    if ! CURRENT="$(ddcutil getvcp "$VCP" -t --bus "$BUS" |
        awk '{print $4}')"; then
        echo "Failed to read monitor brightness" >&2
        exit 1
    fi
fi

if [[ ! "$CURRENT" =~ ^[0-9]{1,3}$ ]] || (( 10#$CURRENT > 100 )); then
    echo "Invalid brightness value: $CURRENT" >&2
    exit 1
fi

CURRENT=$((10#$CURRENT))

if [[ "$1" == "up" ]]; then
    NEW=$((CURRENT + STEP))
    if (( NEW > 100 )); then NEW=100; fi
else
    NEW=$((CURRENT - STEP))
    if (( NEW < 0 )); then NEW=0; fi
fi

printf '%s\n' "$NEW" > "$CACHE_FILE"

# Give each request a unique ID. Only the newest request should apply.
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

if [[ "$(cat "$REQUEST_FILE")" != "$REQUEST_ID" ]]; then
    exit 0
fi

ddcutil setvcp "$VCP" "$NEW" --bus "$BUS" --noverify

