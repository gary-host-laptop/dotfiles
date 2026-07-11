#!/bin/bash

INBOX="$HOME/strata/10-19_system/16_inbox"
SCREENSHOTS="$HOME/Pictures/Screenshots"
IMAGES="$HOME/strata/30-39_media/33_images/inbox"
SCREENSHOTS_DST="$HOME/strata/30-39_media/33_images/screenshots"

inotifywait -m -e close_write -e moved_to --format '%w%f' \
    "$INBOX" "$SCREENSHOTS" | while read -r filepath; do

    filename=$(basename "$filepath")
    dir=$(dirname "$filepath")

    case "${filename,,}" in
        *.jpg|*.jpeg|*.png|*.webp|*.gif)
            if [ "$dir" = "$SCREENSHOTS" ]; then
                mv "$filepath" "$SCREENSHOTS_DST/"
            else
                mv "$filepath" "$IMAGES/"
            fi
            ;;
    esac
done
