#!/bin/bash

INBOX="$HOME/strata/10-19_system/16_inbox"
SCREENSHOTS="$HOME/Pictures/Screenshots"
IMAGES="$HOME/strata/30-39_media/33_images/inbox"
SCREENSHOTS_DST="$HOME/strata/30-39_media/33_images/screenshots"

# ensure watch+dest dirs exist before the loop starts
mkdir -p "$INBOX" "$SCREENSHOTS" "$IMAGES" "$SCREENSHOTS_DST"

# move to dest, keeping both files on name collision (base (1).ext style)
move_file() {
    local src="$1" dest="$2"
    local name base ext n

    name=$(basename "$src")

    if [ ! -e "$dest/$name" ]; then
        mv "$src" "$dest/" || { echo "mv failed: $src -> $dest/" >&2; return; }
        return
    fi

    if [[ "$name" == *.* ]]; then
        base="${name%.*}"; ext=".${name##*.}"
    else
        base="$name"; ext=""
    fi

    n=1
    while [ -e "$dest/$base ($n)$ext" ]; do
        n=$((n + 1))
    done
    mv "$src" "$dest/$base ($n)$ext" || { echo "mv failed: $src -> $dest/$base ($n)$ext" >&2; return; }
}

inotifywait -m -e close_write -e moved_to --format '%w%f' \
    "$INBOX" "$SCREENSHOTS" | while read -r filepath; do

    filename=$(basename "$filepath")
    dir=$(dirname "$filepath")

    case "${filename,,}" in
        *.jpg|*.jpeg|*.png|*.webp|*.gif)
            if [ "$dir" = "$SCREENSHOTS" ]; then
                move_file "$filepath" "$SCREENSHOTS_DST"
            else
                move_file "$filepath" "$IMAGES"
            fi
            ;;
    esac
done