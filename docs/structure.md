# ｓｔｒｕｃｔｕｒｅ

the chezmoi source dir is `strata/` (set via `.chezmoiroot`). chezmoi naming conventions:
`dot_` → `.`, `private_` → 600 perms, `executable_` → 755, `.tmpl` → rendered as Go template.

this is a curated map, not an exhaustive file listing. `chezmoi managed` is authoritative;
`chezmoi unmanaged` shows machine-local files that are intentionally outside the repo.
app status and install details live in [`apps.md`](apps.md).

```
dotfiles/
├── .chezmoiroot
├── README.md
├── LICENSE
├── .gitignore
├── docs/
└── strata/                             # chezmoi source root
    ├── private_dot_bashrc.tmpl         # ~/.bashrc
    ├── private_dot_bash_profile        # ~/.bash_profile
    ├── private_dot_profile.tmpl        # ~/.profile (login/tty PATH fallback)
    ├── private_dot_gitconfig           # ~/.gitconfig
    ├── dot_gemrc.tmpl                  # ~/.gemrc
    ├── .chezmoiignore                  # generated/runtime files chezmoi must not own
    ├── .chezmoitemplates/
    │   ├── strata-backup.service       # system Plakar backup unit
    │   ├── strata-backup.timer         # system Plakar timer unit
    │   └── firefox-policies.json       # Firefox extension policy payload
    ├── dot_bash/
    │   ├── aliases.bash
    │   ├── exports.bash
    │   ├── eza-colors
    │   └── drift.bash
    ├── dot_config/
    │   ├── environment.d/90-user.conf  # systemd --user PATH + XDG roots
    │   ├── user-dirs.conf              # disables xdg-user-dirs-update
    │   ├── user-dirs.dirs              # declarative XDG user directories
    │   ├── systemd/user/               # move-media, wallpaper, wallpaper.timer
    │   ├── nushell/                    # config.nu + env.nu.tmpl
    │   │   # history.txt / starship-init.nu / zoxide.nu are generated and ignored
    │   ├── ghostty/                    # terminal + custom CSS/themes
    │   ├── kitty/                      # terminal
    │   ├── helix/                      # editor + theme
    │   ├── zellij/                     # multiplexer + layouts/themes
    │   ├── yazi/                       # TUI file manager (probationary)
    │   ├── superfile/                  # TUI file manager (primary TUI)
    │   ├── strata/                     # Strata GUI file manager settings
    │   ├── btop/                       # system monitor + theme
    │   ├── fastfetch/                  # system info + logo
    │   ├── bat/                        # syntax highlighter + theme
    │   ├── glow/                       # markdown reader
    │   ├── drift/                      # idle screensaver
    │   ├── lazygit/                    # git TUI + theme
    │   ├── rmpc/                       # mpd TUI client + theme
    │   ├── mpd/                        # music player daemon + playlists
    │   ├── flameshot/                  # screenshot tool
    │   ├── vlc/                        # video player (modify_ script)
    │   ├── jagalite.superseedr/        # torrent client
    │   ├── antimicrox/                 # gamepad mapper (modify_ script)
    │   ├── retroarch/                  # core config + per-core BIOS overrides
    │   ├── keepassxc/                  # password manager
    │   ├── zotero/                     # Zotero profile modify_ script
    │   ├── autostart/                  # Flameshot only
    │   ├── gtk-3.0/bookmarks.tmpl      # Nautilus/GTK sidebar
    │   ├── starship.toml               # shell prompt
    │   └── topgrade.toml.tmpl          # multi-tool updater
    ├── dot_var/app/
    │   ├── dev.zed.Zed/                # Zed settings + sevastolink theme
    │   └── org.nicotine_plus.Nicotine/ # Nicotine+ config (password templated)
    ├── dot_aMule/
    │   └── modify_amule.conf.tmpl      # aMule config (KAD key via [data.amule])
    ├── dot_mozilla/private_firefox/    # pinned Firefox profiles.ini/installs.ini
    │   └── private_ghost-profile/      # user.js + handlers.json
    ├── private_dot_zotero/             # pinned Zotero profile store
    ├── dot_local/
    │   ├── bin/                        # strata-backup, bbit, clipclear, move-media,
    │   │                               # retroarch-playlists, strata-status, wallpaper
    │   └── share/icons/                # hicolor app-grid icons
    └── .chezmoiscripts/
        ├── run_onchange_enable-units.sh
        ├── run_onchange_install-strata-backup-units.sh.tmpl
        ├── run_onchange_install-firefox-policies.sh.tmpl
        ├── run_onchange_install-packages.sh.tmpl
        ├── run_once_generate-nushell-init.sh.tmpl
        ├── run_setup-storage.sh.tmpl
        └── run_once_setup-xdg.sh.tmpl
```

## ｓｃｒｉｐｔｓ

scripts execute in source/name order with respect to managed files. `run_once_` runs once
per unique content; `run_onchange_` reruns when its content changes; `run_` runs on every
apply. storage repair uses `run_` so missing drives are relinked when they return.

## ｒｕｌｅｓ

- keep credentials out of the source tree; use `~/.config/chezmoi/chezmoi.toml` data.
- put app-owned runtime state in `.chezmoiignore`, not in the repo.
- prefer `modify_` scripts for apps that rewrite their own config on exit.
- use `chezmoi managed` and `chezmoi status` after structural changes.
