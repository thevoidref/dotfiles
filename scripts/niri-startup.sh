#!/usr/bin/env bash
# niri-startup.sh

niri msg action focus-workspace 1

pavucontrol --tab=4 &
sleep 1

foot --app-id=cmatrix -e cmatrix &
sleep 0.3

foot --app-id=btop -e btop &
sleep 0.3

obsidian &
sleep 1

firefox \
    "https://deezer.com" \
    "https://leboncoin.fr" \
    "https://mail.proton.me" \
    "https://outlook.live.com/mail/0" &
sleep 2

niri msg action focus-workspace 2

sleep 0.3

codium "$HOME/Code/Nixos/" &
sleep 2

foot &
sleep 0.3

codium "$HOME/.dotfiles/" &
sleep 2

vesktop &

niri msg action focus-workspace 3

firefox \
    "https://chat.deepseek.com" \
    "https://chat.qwen.ai" \
    "https://www.theodinproject.com/paths/full-stack-javascript" &

sleep 1

niri msg action focus-workspace 1

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/niri-floating_popup_daemon.sh" &