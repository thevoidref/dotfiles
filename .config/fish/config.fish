# ── Editor ────────────────────────────────────────────────
set -gx EDITOR nvim
set -gx VISUAL nvim

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
abbr -a nixsw 'sudo nixos-rebuild switch --flake /etc/nixos#dell-laptop'
abbr -a llamaserv 'llama-server -hf ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF --port 8012 -ub 512 \
        -b 512 --ctx-size 2048 --cache-reuse 256 -ngl 99 -t 8 -fa on -dt 0.1'

# ── Tools ─────────────────────────────────────────────────
zoxide init fish | source
starship init fish | source
