#!/usr/bin/env bash
# niri-floating_popup_daemon.sh

set -euo pipefail

RULES=(
    "firefox:Sign in"
    "firefox:Library"
    "firefox:History"
    'Thunar:Rename "'
)

JQ_RULES=$(printf '%s\n' "${RULES[@]}" | jq -R . | jq -s .)

niri msg --json event-stream | jq --unbuffered -c --argjson rules "$JQ_RULES" '
  # Extract any nested window object inside any event dynamically
  .[].window?
  | select(. != null)
  | . as $w
  | $rules[]
  | split(":") as $r
  | select($w.app_id == $r[0] and ($w.title != null) and ($w.title | contains($r[1])))
  | $w.id
' | while read -r id; do
    (
        sleep 0.005
        niri msg action move-window-to-floating --id "$id" 2>/dev/null
        niri msg action set-window-height "50%" 2>/dev/null
        niri msg action center-window 2>/dev/null
    ) &
done
