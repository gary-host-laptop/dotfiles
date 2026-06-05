# dotfiles

personal system configuration for a fedora linux setup, organized within a johnny decimal inspired [strata](https://johnnydecimal.com/) file system.

## structure

```
dotfiles/
├── bash/           # shell config — *.symlink files land in ~/
│   ├── bashrc.symlink
│   ├── exports.bash
│   ├── aliases.bash
│   └── gitconfig.symlink
├── bin/            # personal scripts — linked to ~/bin/
│   ├── apugure     # system update script (dnf + flatpak)
│   └── move-media.sh  # watches inbox and screenshots, moves images
├── config/         # xdg config files — linked to ~/.config/
│   └── starship.toml
├── docs/
│   └── apps.md     # app inventory, install notes, probationary list
├── systemd/        # user units — linked to ~/.config/systemd/user/
│   └── move-media.service
└── script/
    ├── bootstrap   # main setup script
    ├── links       # recreates hdd symlinks inside strata
    ├── packages    # installs essential dnf/flatpak/rpm packages
    └── xdg         # sets xdg user dirs and gnome screenshot path
```

## machines

- **ghost-desktop** — main fedora workstation
- two hdds: **valus** (`/mnt/valus`) and **phaedra** (`/mnt/phaedra`)

## strata layout

```
~/strata/
├── 10-19_system/       # os config, dotfiles, obsidian notes
│   └── 13_system-config/dotfiles/  ← this repo
├── 20-29_praxis/       # active projects, development
└── 30-39_media/        # all media — points into hdds via symlinks
    ├── 31_text         → /mnt/valus/31_text
    ├── 32_audio        → /mnt/valus/32_audio
    ├── 33_images       → /mnt/valus/33_images
    │   ├── images/     # general image library (monbooru)
    │   └── screenshots/
    ├── 34_video        → /mnt/phaedra/34_video
    └── 35_video-games/
        ├── games-library → /mnt/valus/35_video-games/games-library
        └── steam         → /mnt/phaedra/35_video-games/SteamLibrary
```

strata lives on its own partition and survives os reinstalls.

## fresh install

clone the repo into its place within strata:

```bash
git clone git@github.com:gary-host-laptop/dotfiles.git \
  ~/strata/10-19_system/13_system-config/dotfiles
```

run bootstrap (installs deps, symlinks everything, enables services):

```bash
cd ~/strata/10-19_system/13_system-config/dotfiles
chmod +x script/bootstrap script/links script/packages script/xdg
./script/bootstrap
```

install essential packages:

```bash
./script/packages
```

set xdg user dirs (once strata is in place):

```bash
./script/xdg
```

## what bootstrap does

- installs `inotify-tools` if missing
- `*.symlink` files in `bash/` → symlinked to `~/.<name>`
- files in `config/` → symlinked to `~/.config/<name>`
- files in `bin/` → symlinked to `~/bin/` and made executable
- files in `systemd/` → symlinked to `~/.config/systemd/user/`, then `daemon-reload`
- enables and starts all systemd units
- runs `script/links` to recreate hdd symlinks inside strata
- backs up anything it would overwrite to `~/.dotfiles-backup/`

## automation

`move-media.service` watches two directories using inotifywait and moves images automatically:

- `~/strata/10-19_system/16_inbox` → `~/strata/30-39_media/33_images/images/`
- `~/Pictures/Screenshots` → `~/strata/30-39_media/33_images/screenshots/`

monitored extensions: jpg, jpeg, png, webp, gif
