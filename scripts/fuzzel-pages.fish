#!/usr/bin/env fish
# fuzzel-docs.fish
function smart_open
    set -l url $argv[1]

    set -l ws (
        niri msg -j workspaces |
        jq '.[] | select(.is_focused) | .id'
    )

    set -l browser_id (
        niri msg -j windows |
        jq -r --argjson ws "$ws" '
            .[]
            | select(.workspace_id == $ws)
            | select(.app_id? | test("firefox|chrome|chromium|brave"; "i"))
            | .id
        ' |
        head -n1
    )

    if test -n "$browser_id"
        xdg-open "$url" >/dev/null 2>&1 &

        niri msg action focus-window --id "$browser_id"
    else
        firefox --new-window "$url" >/dev/null 2>&1 &
    end
end

set -l choice (
    printf "%s\n" \
        ArchWiki Noctalia Niri NixPkgs \
        Yazi Fish PostgreSQL Wallhaven \
    | sort \
    | fuzzel --dmenu --prompt "Pages ❯ "
)

switch $choice
    case ArchWiki
        smart_open "https://wiki.archlinux.org"
    case Noctalia
        smart_open "https://docs.noctalia.dev/v4/"
    case Niri
        smart_open "https://niri-wm.github.io/niri/"
    case NixPkgs
        smart_open "https://search.nixos.org"

    case Fish
        smart_open "https://fishshell.com/docs/current"
    case PostgreSQL
        smart_open "https://www.postgresql.org/docs/current"
    case Yazi
        smart_open "https://yazi-rs.github.io/docs/quick-start"
    case Wallhaven
        smart_open "https://wallhaven.cc/"
end