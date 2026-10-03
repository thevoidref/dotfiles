# ── Editor ────────────────────────────────────────────────
set -gx EDITOR nvim
set -gx VISUAL nvim
set fish_greeting

# ── PATH additions ─────────────────────────────────────────
fish_add_path $HOME/.dotfiles/scripts

# ── Aliases ───────────────────────────────────────────────
abbr -a ll 'eza -lah --icons --git'
abbr -a la 'eza -A --icons'
abbr -a ls 'eza --icons'
abbr -a lt 'eza --tree --icons --git'
abbr -a vim nvim
abbr -a vi nvim
abbr -a g git
abbr -a dotfiles 'cd ~/.dotfiles'
abbr -a cdnix 'cd ~/Code/Nixos'
abbr -a nixsw 'sudo nixos-rebuild switch --flake /etc/nixos#north-desktop'
abbr -a dofmulti 'cd ~/Code/Games/Dofus && nix-shell'

# ── Tools ─────────────────────────────────────────────────
zoxide init fish | source
starship init fish | source
