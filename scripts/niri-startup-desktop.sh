#!/usr/bin/env bash
# niri-startup-desktop.sh — launch session apps; placement via niri at-startup rules
firefox \
    "https://mail.proton.me/u/2/" \
    "https://mail.proton.me/u/4/" \
    "https://mail.google.com/mail/u/1/" \
    "https://ksuite.infomaniak.com/mail/" \
    "https://leboncoin.fr" &
sleep 1  # let firefox own the profile before the 2nd window
firefox \
    "https://chat.qwen.ai" \
    "https://chatgpt.com" \
    "https://claude.ai/new" &

foot --app-id=cmatrix -e cmatrix &
sleep 0.3
foot --app-id=btop -e btop &
vesktop &
codium ~/.dotfiles &
codium ~/Code/Nixos/main &
thunar ~/Music/Stream/ &
tauon &

sleep 3  # Avoid app taking focus
niri msg action focus-workspace B2
niri msg action focus-workspace A2