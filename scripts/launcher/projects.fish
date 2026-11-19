#!/usr/bin/env fish
# Sans argument : liste les projets. Avec argument : ouvre dans codium.

if set -q argv[1]
    codium (string replace -r '^~' $HOME -- $argv[1])
    exit
end

for root in $HOME/.dotfiles $HOME/Projects $HOME/Code
    test -d $root; or continue
    for dir in $root $root/*/ $root/.*/
        string replace -r "^$HOME" '~' -- $dir | string trim -r -c /
    end
end