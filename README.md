# ｄｏｔｆｉｌｅｓ

personal system configuration for a fedora linux setup organized within a johnny decimal inspired [strata](https://johnnydecimal.com/) file system.

→ [apps](docs/apps.md) · [hardware](docs/hardware.md)

---

## ｓｔｒｕｃｔｕｒｅ

```
dotfiles/
├── bash/
│   ├── bashrc.symlink      # → ~/.bashrc
│   ├── profile.symlink     # → ~/.profile
│   ├── exports.bash        # PATH, env vars
│   ├── aliases.bash        # shell aliases
│   └── gitconfig.symlink   # → ~/.gitconfig
├── bin/                    # → ~/bin/
│   ├── apugure             # system updater (dnf + flatpak)
│   ├── move-media.sh       # moves images from inbox + screenshots
│   ├── strata-status       # disk usage overview
│   └── wallpaper           # random wallpaper setter
├── config/                 # → ~/.config/
│   ├── starship.toml
│   ├── ghostty/
│   │   ├── config.ghostty
│   │   └── custom.css
│   └── fastfetch/
│       ├── config.jsonc
│       └── logo.txt
├── docs/
│   ├── apps.md             # app inventory + install notes
│   └── hardware.md         # machine specs + drive layout
├── systemd/                # → ~/.config/systemd/user/
│   ├── move-media.service
│   ├── wallpaper.service
│   └── wallpaper.timer
└── script/
    ├── bootstrap           # main setup — run first
    ├── links               # hdd symlinks into strata
    ├── packages            # essential dnf/flatpak/rpm installs
    └── xdg                 # user dirs, fonts, cursor, wallpaper default
```

---

## ｍａｃｈｉｎｅ

**ghost-desktop** — fedora workstation
- cpu: amd ryzen 5 5600g
- ram: 8gb ddr4 3000mhz
- hdds: **valus** (`/mnt/valus`) · **phaedra** (`/mnt/phaedra`)

---

## ｓｔｒａｔａ

```
~/strata/
├── 10-19_system/
│   └── 13_system-config/
│       ├── dotfiles/           ← this repo
│       ├── theming/            # cursors, wallpapers, fonts, shimeji
│       └── templates/          # nautilus new-file templates
├── 20-29_praxis/               # active projects, development
└── 30-39_media/
    ├── 31_text     → /mnt/valus/31_text
    ├── 32_audio    → /mnt/valus/32_audio
    ├── 33_images   → /mnt/valus/33_images
    │   ├── images/             # monbooru library
    │   └── screenshots/
    ├── 34_video    → /mnt/phaedra/34_video
    └── 35_video-games/
        ├── games-library → /mnt/valus/35_video-games/games-library
        └── steam         → /mnt/phaedra/35_video-games/SteamLibrary
```

strata lives on its own partition and survives os reinstalls.

---

## ｆｒｅｓｈ　ｉｎｓｔａｌｌ

```bash
git clone git@github.com:gary-host-laptop/dotfiles.git \
  ~/strata/10-19_system/13_system-config/dotfiles

cd ~/strata/10-19_system/13_system-config/dotfiles
chmod +x script/bootstrap script/links script/packages script/xdg
./script/bootstrap   # symlinks, deps, systemd units
./script/packages    # dnf + flatpak installs
./script/xdg         # user dirs, fonts, cursor theme
```

---

## ａｕｔｏｍａｔｉｏｎ

| service | watches | moves to |
|---------|---------|----------|
| `move-media` | `~/strata/10-19_system/16_inbox` | `33_images/images/` |
| `move-media` | `~/Pictures/Screenshots` | `33_images/screenshots/` |
| `wallpaper.timer` | — | picks random from `theming/wallpapers/` every 6h |

extensions monitored: jpg jpeg png webp gif

---

## ｂｏｏｔｓｔｒａｐ

- checks deps (`inotify-tools`, `git`)
- `*.symlink` → `~/.<name>`
- `config/` files and subdirs → `~/.config/`
- `bin/` → `~/bin/` + chmod +x
- `systemd/` → `~/.config/systemd/user/` + daemon-reload + enable
- `script/links` → hdd symlinks into strata
- backs up anything it would overwrite to `~/.dotfiles-backup/`
