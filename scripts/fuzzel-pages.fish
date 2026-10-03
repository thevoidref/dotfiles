#!/usr/bin/env fish
# fuzzel-docs.fish

function smart_open
    set -l url $argv[1]

    set -l ws (
        niri msg -j workspaces |
        jq -r '.[] | select(.is_focused) | .id'
    )

    set -l browser_id (
        niri msg -j windows |
        jq -r --argjson ws "$ws" '
            .[]
            | select(.workspace_id == $ws)
            | select((.app_id // "") | test("firefox|chrome|chromium|brave"; "i"))
            | .id
        ' |
        head -n1
    )

    if test -n "$browser_id"
        firefox "$url" >/dev/null 2>&1 &
        sleep 0.15
        niri msg action focus-window --id "$browser_id"
    else
        firefox --new-window "$url" >/dev/null 2>&1 &
    end
end

set -l choice (
    printf "%s\n" \
        "Arch Wiki" Noctalia Niri NixPkgs \
        Yazi Fish PostgreSQL Wallhaven \
        "Stack Overflow" Mdn Git "W3C Validator" \
        "Odin Project" W3Schools Github OpenCode \
        Astro TailWindCSS \
    | sort \
    | fuzzel --dmenu --prompt "Pages ❯ "
)

switch $choice
    case "Arch Wiki"
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

    case "Stack Overflow"
        smart_open https://stackoverflow.com/questions
    case Mdn
        smart_open "https://developer.mozilla.org/en-US/"
    case Git
        smart_open "https://git-scm.com/learn"
    case "W3C Validator"
        smart_open "https://validator.w3.org/"

    case "Odin Project"
        smart_open "https://www.theodinproject.com/about"
    case W3Schools
        smart_open "https://www.w3schools.com/"
    case Github
        smart_open "https://github.com/"
    case OpenCode
        smart_open "https://opencode.ai/docs"

    case Astro
        smart_open "https://docs.astro.build/en/getting-started/"
    case TailWindCSS
        smart_open "https://tailwindcss.com/docs/installation/using-vite"
        
end