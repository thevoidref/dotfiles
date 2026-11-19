#!/usr/bin/env fish
# Sans argument : liste les pages. Avec argument : ouvre la page.

set -l pages \
    "Arch Wiki"      https://wiki.archlinux.org \
    Noctalia         https://docs.noctalia.dev/ \
    Niri             https://niri-wm.github.io/niri/ \
    NixPkgs          https://search.nixos.org \
    Fish             https://fishshell.com/docs/current \
    PostgreSQL       https://www.postgresql.org/docs/current \
    Yazi             https://yazi-rs.github.io/docs/quick-start \
    Wallhaven        https://wallhaven.cc/ \
    "Stack Overflow" https://stackoverflow.com/questions \
    Mdn              https://developer.mozilla.org/en-US/ \
    Git              https://git-scm.com/learn \
    "W3C Validator"  https://validator.w3.org/ \
    "Odin Project"   https://www.theodinproject.com/about \
    W3Schools        https://www.w3schools.com/ \
    Github           https://github.com/ \
    OpenCode         https://opencode.ai/docs \
    Astro            https://docs.astro.build/en/getting-started/ \
    TailWindCSS      https://tailwindcss.com/docs/installation/using-vite \
    WallpaperCave    https://wallpapercave.com/ \
    localHost4321    http://localhost:4321/ \
    localHost5690    http://localhost:5690/

function smart_open
    set -l url $argv[1]
    set -l ws (niri msg -j workspaces | jq -r '.[] | select(.is_focused) | .id')
    set -l browser_id (niri msg -j windows | jq -r --argjson ws "$ws" '
        .[] | select(.workspace_id == $ws)
            | select((.app_id // "") | test("firefox-pro"; "i")) | .id' | head -n1)

    if test -n "$browser_id"
        firefox --no-remote -P pro --name firefox-pro "$url" >/dev/null 2>&1 &
        disown
        sleep 0.15
        niri msg action focus-window --id "$browser_id"
    else
        firefox --no-remote -P pro --name firefox-pro --new-window "$url" >/dev/null 2>&1 &
        disown
    end
end

# Mode liste
if not set -q argv[1]
    for i in (seq 1 2 (count $pages))
        echo $pages[$i]
    end | sort
    exit
end

# Mode ouverture ("$argv" recolle "Arch Wiki" même si Noctalia le coupe en deux)
set -l choice "$argv"
set -l idx (contains -i -- $choice $pages); or exit 1
set -l url $pages[(math $idx + 1)]

if test "$choice" = localHost5690
    firefox $url >/dev/null 2>&1 &
    disown
else
    smart_open $url
end