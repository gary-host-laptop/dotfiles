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
    local name base ext n dst

    name=$(basename "$src")

    if [ ! -e "$dest/$name" ]; then
        dst="$dest/$name"
    else
        if [[ "$name" == *.* ]]; then
            base="${name%.*}"; ext=".${name##*.}"
        else
            base="$name"; ext=""
        fi

        n=1
        while [ -e "$dest/$base ($n)$ext" ]; do
            n=$((n + 1))
        done
        dst="$dest/$base ($n)$ext"
    fi

    mv "$src" "$dst" || { echo "mv failed: $src -> $dst" >&2; return 1; }
    chcon --reference="$dest" "$dst" || { echo "chcon failed: $dst" >&2; return 1; }
    return 0
}

tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/move-media.XXXXXX") || exit 1
watcher_pid=""

cleanup() {
    if [ -n "$watcher_pid" ] && kill -0 "$watcher_pid" 2>/dev/null; then
        kill "$watcher_pid" 2>/dev/null || true
        wait "$watcher_pid" 2>/dev/null || true
    fi
    rm -rf "$tmpdir"
}
trap cleanup EXIT

fifo="$tmpdir/watch"
mkfifo "$fifo" || exit 1

inotifywait -m -e close_write -e moved_to --format '%w%f' \
    "$INBOX" "$SCREENSHOTS" >"$fifo" &
watcher_pid=$!

move_failed=0
while IFS= read -r filepath; do
    filename=$(basename "$filepath")
    dir=$(dirname "$filepath")

    case "${filename,,}" in
        *.jpg|*.jpeg|*.png|*.webp|*.gif)
            if [ "$dir" = "$SCREENSHOTS" ]; then
                if ! move_file "$filepath" "$SCREENSHOTS_DST"; then
                    move_failed=1
                    break
                fi
            else
                if ! move_file "$filepath" "$IMAGES"; then
                    move_failed=1
                    break
                fi
            fi
            ;;
    esac
done <"$fifo"

watcher_status=0
if [ "$move_failed" -eq 0 ]; then
    wait "$watcher_pid"
    watcher_status=$?
    watcher_pid=""
fi

if [ "$move_failed" -ne 0 ] || [ "$watcher_status" -ne 0 ]; then
    exit 1
fi
