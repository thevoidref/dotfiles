#!/usr/bin/env fish
# fuzzel-prompts.fish

set -l prompt_dir ~/.dotfiles/prompts

cd "$prompt_dir"

set -l selected (
    fd . \
        --type f \
        --extension md \
    | sort \
    | fuzzel --dmenu --prompt "Prompt ❯ "
)

test -z "$selected"; and exit 0

wl-copy < "$selected"

set -l json (
    jq -cn \
        --arg title "Prompt copied" \
        --arg body (path basename "$selected") \
        --arg icon "media-record" \
        '{title:$title, body:$body, icon:$icon}'
)

noctalia-shell ipc call toast send "$json"