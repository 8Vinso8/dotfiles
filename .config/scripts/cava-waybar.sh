#!/usr/bin/env bash
set -euo pipefail

exec cava -p "$HOME/.config/cava/config-waybar" | sed -u 's/;//g; y/01234567/ ▂▃▄▅▆▇█/'
