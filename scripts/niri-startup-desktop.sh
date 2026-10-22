#!/usr/bin/env bash
# niri-startup.sh

niri msg action focus-monitor DP-1
sleep 0.2



niri msg action focus-workspace B1

firefox \
    "https://mail.proton.me" \
    "https://outlook.live.com/mail/" \
    "https://ksuite.infomaniak.com/mail/" \
    "https://leboncoin.fr" \
    "https://dashboard.twitch.tv/u/thevoidref/stream-manager" \
    "https://chat.qwen.ai" \
    "https://claude.ai/new" &
sleep 1


niri msg action focus-workspace B2
sleep 0.3

foot --app-id=cmatrix -e cmatrix &
sleep 0.3

foot --app-id=btop -e btop &
sleep 0.3

vesktop &
niri msg action focus-workspace B2
sleep 4


niri msg action focus-workspace A2
sleep 0.3

codium ~/Code/Nixos/main &
sleep 1

codium ~/.dotfiles &
sleep 1


niri msg action focus-workspace A3
sleep 0.5

thunar ~/Music/Stream/ &
sleep 1

tauon &
sleep 3


niri msg action focus-workspace B1
sleep 0.3

obs --scene "Code" --profile "Main" &


SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/niri-floating_popup_daemon.sh" &