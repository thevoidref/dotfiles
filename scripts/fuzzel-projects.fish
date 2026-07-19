#!/usr/bin/env fish
# fuzzel-projects.fish

set -l roots "$HOME/.dotfiles" "$HOME/Projects" "$HOME/Code"
set -l choices

for root in $roots
    if not test -d "$root"
        continue
    end

    set -a choices "~/"(string replace "$HOME/" "" "$root" | string trim -r -c /)

    for dir in "$root"/*/
        test -d "$dir" && set -a choices "~/"(string replace "$HOME/" "" "$dir" | string trim -r -c /)
    end

    for dir in "$root"/.*/
        set -l name (basename "$dir")
        test "$name" = "." || test "$name" = ".." && continue
        test -d "$dir" && set -a choices "~/"(string replace "$HOME/" "" "$dir" | string trim -r -c /)
    end
end

set -l choice (
    printf "%s\n" $choices | fuzzel --dmenu --prompt "Project ❯ "
)

if test -n "$choice"
    # Expand ~ back to real path before opening
    codium (string replace "~" "$HOME" "$choice") &
end