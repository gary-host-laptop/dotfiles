#!/bin/bash

# =============================================================================
# Reload and enable systemd user units
# Runs after managed unit files are applied; hashes below make unit edits
# trigger a rerun.
# =============================================================================

# hash: {{ include "dot_config/systemd/user/move-media.service" | sha256sum }}
# hash: {{ include "dot_config/systemd/user/wallpaper.service" | sha256sum }}
# hash: {{ include "dot_config/systemd/user/wallpaper.timer" | sha256sum }}

set -euo pipefail

info()    { echo "  [ .. ] $1"; }
success() { echo "  [ ok ] $1"; }

info "reloading systemd daemon..."
systemctl --user daemon-reload
success "systemd daemon reloaded"

for unit in move-media.service wallpaper.timer; do
    info "enabling $unit..."
    systemctl --user enable "$unit"
    systemctl --user restart "$unit"
    success "enabled and restarted $unit"
done

info "wallpaper.service is static and triggered by wallpaper.timer"
