#!/usr/bin/env fish
# Sans argument : liste les .md. Avec argument : copie et notifie.

set -l dir ~/.dotfiles/strings
cd $dir; or exit 1

if not set -q argv[1]
    fd . --type f --extension md | sort
    exit
end

set -l file "$argv"
test -f "$file"; or exit 1

wl-copy < "$file"
notify-send -i media-record "Text copied" (path basename "$file")