# ｓｔｒｕｃｔｕｒｅ

the chezmoi source dir is `strata/` (set via `.chezmoiroot`).

this is a curated map, not an exhaustive file listing. `chezmoi managed` is authoritative;
`chezmoi unmanaged` shows machine-local files that are intentionally outside the repo.

```
dotfiles/
├── .chezmoiroot
├── README.md
├── LICENSE
├── .gitignore
├── docs/
└── strata/                             # chezmoi source root
    ├── private_dot_bashrc.tmpl         # interactive bash config
    ├── private_dot_bash_profile        # login shell config
    ├── private_dot_profile.tmpl        # login/tty PATH entry point
    ├── private_dot_gitconfig           # git defaults
    ├── dot_gemrc.tmpl
    ├── .chezmoiignore                  # runtime paths chezmoi leaves alone
    ├── .chezmoitemplates/              # system-level file templates
    ├── dot_bash/                       # shell helpers
    ├── dot_config/                     # per-app XDG config
    │   ├── environment.d/90-user.conf  # session PATH baseline and XDG roots
    │   ├── user-dirs.conf              # disables XDG auto-update
    │   ├── user-dirs.dirs              # Strata-backed XDG directories
    │   └── systemd/user/               # user services and timers
    ├── dot_var/app/                    # Flatpak app data
    ├── dot_aMule/
    ├── dot_mozilla/private_firefox/    # pinned Firefox profile paths
    ├── private_dot_zotero/             # pinned Zotero profile paths
    ├── dot_local/
    │   └── bin/                        # local helper commands
    └── .chezmoiscripts/                # apply-time setup scripts
```

## ｃｏｎｔｅｎｔｓ

### `.chezmoitemplates/`

- `strata-backup.service` — systemd service for the Plakar backup.
- `strata-backup.timer` — daily backup timer.
- `firefox-policies.json` — Firefox extension policy.

### `.chezmoiscripts/`

- `run_onchange_after_enable-units.sh` — enables move-media and the wallpaper timer after unit files are applied; wallpaper.service stays timer-triggered.
- `run_onchange_install-firefox-policies.sh.tmpl` — installs the Firefox policy.
- `run_onchange_install-packages.sh.tmpl` — installs packages, Flatpaks, and app installers.
- `run_onchange_install-strata-backup-units.sh.tmpl` — installs the backup service, timer, and binaries.
- `run_once_after_generate-nushell-init.sh.tmpl` — generates the Nushell starship/zoxide init files after packages are installed.
- `run_once_setup-xdg.sh.tmpl` — applies XDG user directories and GNOME theming.
- `run_setup-storage.sh.tmpl` — creates or repairs storage links on each apply.

scripts execute in target-name order with respect to managed files. `run_once_` runs once
per unique content; `run_onchange_` reruns when its content changes; `run_` runs on every
apply. storage repair uses `run_` so missing drives are relinked when they return.

### `dot_bash/`

- `aliases.bash` — aliases and the `yank` wrapper.
- `exports.bash` — shell environment exports.
- `eza-colors` — eza color definitions.
- `drift.bash` — idle-screensaver shell integration.

### `dot_config/`

- `environment.d/90-user.conf` — session PATH baseline and XDG roots.
- `user-dirs.conf` — prevents the XDG updater from rewriting user directories.
- `user-dirs.dirs` — maps Documents, Music, Pictures, and Videos into Strata.
- `systemd/user/` — user services and timers.

### `dot_local/bin/`

- `bbit` — interactive BleachBit cleanup.
- `clipclear` — clears clipboard selections.
- `move-media.sh` — moves inbox and screenshot images into Strata.
- `retroarch-playlists` — regenerates RetroArch playlists from the ROM tree.
- `strata-backup` — runs the Plakar essentials backup.
- `strata-status` — shows storage usage.
- `wallpaper` — sets or rotates the desktop wallpaper.

## ｒｕｌｅｓ

- keep credentials out of the source tree; use `~/.config/chezmoi/chezmoi.toml` data.
- put app-owned runtime state in `.chezmoiignore`, not in the repo.
- prefer `modify_` scripts for apps that rewrite their own config on exit.
- use `chezmoi managed` and `chezmoi status` after structural changes.
