#!/bin/bash
# niri-startup.sh
# Niri startup sequence - ensures windows open in correct order

# Wait for Niri to be ready
sleep 0.3

# Column 1: cmatrix (25%)
foot -e cmatrix &
sleep 0.2

# Column 2: btop (50%)
foot -e btop &
sleep 0.2

# Column 3: obsidian (90%)
obsidian &
sleep 1.2

# Column 4: Firefox multi-tab (80%)
firefox "https://deezer.com" \
  "https://chat.deepseek.com" \
  "https://mail.proton.me" \
  "https://outlook.live.com/mail/0" &
sleep 1

# Column 5: Vesktop (80%)
vesktop &
sleep 0.5

# ============================================
# WORKSPACE 2
# ============================================

# Main column: codium (80%)
codium ~/.dotfiles &
sleep 0.8

# Split into two foot terminals (50% height each)
foot --class=foot1 &
sleep 0.2
foot --class=foot2 &
sleep 0.2

# ============================================
# WORKSPACE 3
# ============================================
niri msg action focus-workspace 3

# Firefox homepage
firefox &
sleep 0.5

# ============================================
# RETURN TO WORKSPACE 1
# ============================================
niri msg action focus-workspace 1
niri msg action focus-column-first

# Start background applications last
noctalia-shell &

echo "Startup complete"