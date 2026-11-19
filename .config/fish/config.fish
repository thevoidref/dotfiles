set -gx EDITOR nvim
set -gx VISUAL nvim
set -g fish_greeting
fish_add_path $HOME/.dotfiles/scripts


status is-interactive; or return

abbr -a ll  'eza -lah --icons --git'
abbr -a la  'eza -A --icons'
abbr -a ls  'eza --icons'
abbr -a lt  'eza --tree --icons --git'
abbr -a vi  nvim
abbr -a vim nvim
abbr -a g   git
abbr -a dotfiles 'cd ~/.dotfiles'
abbr -a cdnix    'cd ~/Code/Nixos'
abbr -a nixsw    'sudo nixos-rebuild switch --flake /etc/nixos#north-desktop'
abbr -a ytdl     'cd ~/Projects/Ytdl && ./ytdl.sh'
abbr -a dofmulti 'cd ~/Code/Games/Dofus && nix-shell'

zoxide init fish | source
starship init fish | source
