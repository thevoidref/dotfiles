#!/usr/bin/env bash
# starship-palette.sh — replace the Noctalia palette block at the end of starship.toml
F="$HOME/.dotfiles/.config/starship.toml"
P="$HOME/.cache/noctalia/starship-palette.toml"
[[ -f "$P" ]] || exit 0
sed -i '/^# >>> NOCTALIA STARSHIP PALETTE >>>/,$d' "$F"
{ echo '# >>> NOCTALIA STARSHIP PALETTE >>>'; cat "$P"; } >> "$F"