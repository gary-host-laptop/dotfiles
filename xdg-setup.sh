#!/usr/bin/env bash
# =============================================================================
# XDG user dirs + GNOME screenshot path setup
# Run after reinstall once JD tree and symlinks are in place.
# =============================================================================

# -----------------------------------------------------------------------------
# 1. XDG user dirs
# -----------------------------------------------------------------------------
cat > "$HOME/.config/user-dirs.dirs" << 'EOF'
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run.
# Format is XDG_xxx_DIR="$HOME/..."

XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/JD/50-59_system/54_inbox"
XDG_TEMPLATES_DIR="$HOME/JD/50-59_system/52_system-config/desktop/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/JD/50-59_system/54_inbox"
XDG_MUSIC_DIR="$HOME/JD/50-59_system/54_inbox"
XDG_PICTURES_DIR="$HOME/JD/50-59_system/54_inbox"
XDG_VIDEOS_DIR="$HOME/JD/50-59_system/54_inbox"
EOF

xdg-user-dirs-update

# -----------------------------------------------------------------------------
# 2. GNOME screenshot save location
# -----------------------------------------------------------------------------
gsettings set org.gnome.gnome-screenshot auto-save-directory \
  "$HOME/JD/40-49_media/43_images/screenshots"

echo "Done."
