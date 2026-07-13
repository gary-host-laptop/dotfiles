# ｄｏｔｆｉｌｅｓ

personal system configuration for a fedora linux setup organized within a [johnny decimal](https://johnnydecimal.com/) inspired strata file system.

---

## ｓｔｒｕｃｔｕｒｅ

```
dotfiles/
├── bash/						# Shell configuration
│   ├── bashrc.symlink		# → ~/.bashrc
│   ├── profile.symlink		# → ~/.profile
│   ├── exports.bash			# PATH, env vars
│   ├── aliases.bash			# shell aliases
│   └── gitconfig.symlink		# → ~/.gitconfig
├── bin/						# Executable utilities
│   ├── apugure				# system updater (dnf + flatpak)
│   ├── move-media.sh			# moves images from inbox + screenshots
│   ├── strata-status			# disk usage overview
│   └── wallpaper				# random wallpaper setter
├── config/					# Application configurations
│   ├── starship.toml
│   ├── ghostty/
│   │   ├── config.ghostty
│   │   └── custom.css
│   └── fastfetch/
│       ├── config.jsonc
│       └── logo.txt
├── docs/
│   ├── apps.md				# app inventory + install notes
│   └── hardware.md			# machine specs + drive layout
├── systemd/					# System automation
│   ├── move-media.service
│   ├── wallpaper.service
│   └── wallpaper.timer
└── script/
    ├── bootstrap				# main setup — run first
    ├── links					# hdd symlinks into strata
    ├── packages				# essential dnf/flatpak/rpm installs
    └── xdg					# user dirs, fonts, cursor, wallpaper default
```

---

## ｓｔｒａｔａ

```
~/strata/
├── 10-19_system/
│   └── 13_system-config/
│       ├── dotfiles/           ← this repo
│       ├── theming/            
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
./script/bootstrap
./script/packages
./script/xdg
```

---

## ｂｏｏｔｓｔｒａｐ

- checks deps (`inotify-tools`, `git`)
- `*.symlink` → `~/.<name>`
- `config/` files and subdirs → `~/.config/`
- `bin/` → `~/bin/` + chmod +x
- `systemd/` → `~/.config/systemd/user/` + daemon-reload + enable
- `script/links` → hdd symlinks into strata
- backs up anything it would overwrite to `~/.dotfiles-backup/`
