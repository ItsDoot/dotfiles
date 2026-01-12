#!/bin/bash

if [ -z "$PLAYER" ]; then
    echo "PLAYER environment variable is not set. Please set it to your media player (e.g., spotify, vlc, etc)."
    exit 1
fi

playerctl \
    --follow metadata \
    --player "$PLAYER" \
    --format '{"text":"{{markup_escape(artist)}} - {{markup_escape(title)}}","class":"{{lc(status)}}","alt":"{{lc(status)}}","tooltip":"{{markup_escape(artist)}} - {{markup_escape(title)}}\r{{markup_escape(album)}}","percentage":{{volume * 100}}}' \
    2>/dev/null | while read -r line; do
    out=$(jq --unbuffered --compact-output '.text |= if length > 40 then .[:40] + "..." else . end' <<< "$line" 2>/dev/null)
    # check if jq was able to parse the output or if the output is empty, return fallback if so
    if [ $? -ne 0 ]; then
        echo "" # we'll hide the module if the output is empty
        continue
    fi

    echo "$out"
done