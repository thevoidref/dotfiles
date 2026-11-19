#!/usr/bin/env bash
# niri-floating_popup_daemon.sh — float popups whose title is set after open
set -euo pipefail

# Single instance
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/niri-float.lock"
flock -n 9 || exit 0

RULES=(
    "firefox:Library"
    "firefox:History"
    'Thunar:Rename "'
    'thunar:Rename "'
)
JQ_RULES=$(printf '%s\n' "${RULES[@]}" | jq -R . | jq -s .)

declare -A seen
niri msg --json event-stream | jq --unbuffered -r --argjson rules "$JQ_RULES" '
  .[].window? // empty
  | . as $w
  | select(any($rules[]; split(":") as $r
      | $w.app_id == $r[0] and (($w.title // "") | startswith($r[1]))))
  | $w.id
' | while read -r id; do
    [[ -n "${seen[$id]:-}" ]] && continue
    seen[$id]=1
    niri msg action move-window-to-floating --id "$id"
    niri msg action set-window-height --id "$id" "50%"
    niri msg action center-window --id "$id"
done 2>/dev/null
