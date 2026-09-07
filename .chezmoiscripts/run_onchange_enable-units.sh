#!/bin/bash

# =============================================================================
# Enable systemd user units
# Runs on change — re-enables units when service files are updated
# =============================================================================

info()    { echo "  [ .. ] $1"; }
success() { echo "  [ ok ] $1"; }
warn()    { echo "  [warn] $1"; }

info "reloading systemd daemon..."
systemctl --user daemon-reload
success "systemd daemon reloaded"

info "enabling systemd units..."
for unit in move-media.service wallpaper.service wallpaper.timer; do
    if systemctl --user enable --now "$unit" 2>/dev/null; then
        success "enabled $unit"
    else
        warn "failed to enable $unit — run 'systemctl --user status $unit'"
    fi
done
