#!/usr/bin/env fish
# Sans argument : liste les pages. Avec argument : ouvre la page.
# Format : nom url profil (1 = firefox-pro, 2 = firefox main)

set -l pages \
    "Arch Wiki"      https://wiki.archlinux.org                          1 \
    Noctalia         https://docs.noctalia.dev/                          1 \
    Niri             https://niri-wm.github.io/niri/                     1 \
    NixPkgs          https://search.nixos.org                            1 \
    Fish             https://fishshell.com/docs/current                  1 \
    PostgreSQL       https://www.postgresql.org/docs/current             1 \
    Yazi             https://yazi-rs.github.io/docs/quick-start          1 \
    Wallhaven        https://wallhaven.cc/                               1 \
    "Stack Overflow" https://stackoverflow.com/questions                 1 \
    Mdn              https://developer.mozilla.org/en-US/                1 \
    Git              https://git-scm.com/learn                           1 \
    "W3C Validator"  https://validator.w3.org/                           1 \
    "Odin Project"   https://www.theodinproject.com/about                2 \
    W3Schools        https://www.w3schools.com/                          1 \
    Github           https://github.com/                                 2 \
    OpenCode         https://opencode.ai/docs                            1 \
    Astro            https://docs.astro.build/en/getting-started/        1 \
    TailWindCSS      https://tailwindcss.com/docs/installation/using-vite 1 \
    WallpaperCave    https://wallpapercave.com/                          1 \
    localHost4321    http://localhost:4321/                              1 \
    localHost5690    http://localhost:5690/                              2

function smart_open
    set -l url $argv[1]
    set -l mode $argv[2]

    if test "$mode" = 2
        set -f app '^firefox$'
        set -f cmd firefox
    else
        set -f app '^firefox-pro$'
        set -f cmd firefox --no-remote -P pro --name firefox-pro
    end

    set -l browser_id (niri msg -j windows | jq -r --arg app "$app" '
        [.[] | select((.app_id // "") | test($app; "i"))]
        | sort_by(.focus_timestamp.secs // 0, .focus_timestamp.nanos // 0)
        | last | .id // empty')

    if test -n "$browser_id"
        $cmd "$url" >/dev/null 2>&1 &
        disown
        sleep 0.15
        niri msg action focus-window --id "$browser_id"
    else
        $cmd --new-window "$url" >/dev/null 2>&1 &
        disown
    end
end

# Mode liste
if not set -q argv[1]
    for i in (seq 1 3 (count $pages))
        echo $pages[$i]
    end | sort
    exit
end

# Mode ouverture ("$argv" recolle "Arch Wiki" même si Noctalia le coupe en deux)
set -l choice "$argv"
for i in (seq 1 3 (count $pages))
    if test "$pages[$i]" = "$choice"
        smart_open $pages[(math $i + 1)] $pages[(math $i + 2)]
        exit
    end
end
exit 1