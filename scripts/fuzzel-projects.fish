#!/usr/bin/env fish
# fuzzel-projects.fish

set -l project (
    printf "%s\n" \
        "$HOME/.dotfiles" \
        "$HOME/.dotfiles/nixos" \
        "$HOME/.dotfiles/scripts" \
    | fuzzel --dmenu --prompt "Project ❯ "
)

test -n "$project"; and codium "$project" &