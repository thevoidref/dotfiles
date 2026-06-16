#!/usr/bin/env bash
# niri-startup.sh

niri msg action focus-workspace 1

foot --app-id=cmatrix -e cmatrix &
sleep 0.3

foot --app-id=btop -e btop &
sleep 0.3

obsidian &
sleep 1

firefox \
    "https://deezer.com" \
    "https://chat.deepseek.com" \
    "https://mail.proton.me" \
    "https://outlook.live.com/mail/0" &
sleep 1

vesktop &

niri msg action focus-workspace 2

foot --app-id=foot1 &
sleep 0.3

codium "$HOME/.dotfiles/" &
sleep 1

foot --app-id=foot2 &
sleep 0.3

niri msg action focus-workspace 3

firefox &
sleep 1

niri msg action focus-workspace 1

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/niri-floating_popup_daemon.sh" &