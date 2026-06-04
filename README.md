# dotfiles

personal system configuration for a fedora linux setup, organized within the [strata](https://johnnydecimal.com/) file system.

## structure

```
dotfiles/
├── bash/           # shell config — *.symlink files land in ~/
├── bin/            # personal scripts — linked to ~/bin/
├── config/         # xdg config files — linked to ~/.config/
├── systemd/        # user units — linked to ~/.config/systemd/user/
└── script/
    ├── bootstrap   # main setup script
    ├── links       # recreates hdd symlinks inside strata
    └── xdg         # sets xdg user dirs and gnome screenshot path
```

## machines

- **ghost-desktop** — main fedora workstation
- two hdds: **valus** (`/mnt/valus`) and **phaedra** (`/mnt/phaedra`)

## strata layout

the home directory is organized using a johnny decimal inspired structure:

```
~/strata/
├── 10-19_system/       # os config, dotfiles, obsidian notes
├── 20-29_praxis/       # active projects, development
└── 30-39_media/        # all media — points into hdds via symlinks
    ├── 31_text         → /mnt/valus/31_text
    ├── 32_audio        → /mnt/valus/32_audio
    ├── 33_images       → /mnt/valus/33_images
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

run bootstrap:

```bash
cd ~/strata/10-19_system/13_system-config/dotfiles
chmod +x script/bootstrap script/links script/xdg
./script/bootstrap
```

then run the xdg setup (once strata is in place):

```bash
./script/xdg
```

## what bootstrap does

- `*.symlink` files in `bash/` → symlinked to `~/.<name>`
- files in `config/` → symlinked to `~/.config/<name>`
- files in `bin/` → symlinked to `~/bin/` and made executable
- files in `systemd/` → symlinked to `~/.config/systemd/user/`, then `daemon-reload`
- runs `script/links` to recreate hdd symlinks inside strata
- backs up anything it would overwrite to `~/.dotfiles-backup/`
