#!/usr/bin/env bash
# niri-startup.sh

LLAMA_SERV="llama-server -hf ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF -ub 512 -b 512 --ctx-size 2048 --cache-reuse 256 -ngl 99 -t 8 -fa on"

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
    "https://chat.deepseek.com" \
    "https://mail.proton.me" \
    "https://outlook.live.com/mail/0" &
sleep 2

niri msg action focus-workspace 2

foot --app-id=foot1 $LLAMA_SERV --port 8011 &
sleep 0.3

codium "$HOME/.dotfiles/" &
sleep 2

vesktop &

niri msg action focus-workspace 3

firefox &
sleep 1

niri msg action focus-workspace 1

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/niri-floating_popup_daemon.sh" &