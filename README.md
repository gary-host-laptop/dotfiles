# ｄｏｔｆｉｌｅｓ

personal system configuration for a fedora linux setup organized within a [johnny decimal](https://johnnydecimal.com/) inspired strata file system.

## ｓｔｒｕｃｔｕｒｅ

```
dotfiles/
├── bash/					# shell configuration
│   ├── bashrc.symlink		# bash/bashrc.symlink → ~/.bashrc
│   ├── profile.symlink		# bash/profile.symlink → ~/.profile
│   ├── exports.bash		# PATH, env vars
│   ├── aliases.bash		# shell aliases
│   └── gitconfig.symlink	# bash/gitconfig.symlink → ~/.gitconfig
├── bin/					# executable utilities
│   ├── bbit				# one-shot BleachBit cleanup (dnf/thumbnails/journal)
│   ├── move-media.sh		# moves images from inbox + screenshots
│   ├── strata-status		# disk usage overview
│   └── wallpaper			# random wallpaper setter
├── config/					# application configurations
├── docs/
│   ├── apps.md				# app inventory + install notes
│   └── hardware.md			# machine specs + drive layout
├── systemd/				# system automation
│   ├── move-media.service
│   ├── wallpaper.service
│   └── wallpaper.timer
└── script/
    ├── bootstrap			# main setup — run first
    ├── links				# hdd symlinks into strata
    ├── packages			# essential dnf/flatpak/rpm/cargo/rust installs
    └── xdg					# user dirs, fonts, cursor, wallpaper default
```

## ｓｔｒａｔａ

```
~/strata/
├── 10-19_system/
│   └── 13_system-config/
│       └── dotfiles/		# 13_system-config/dotfiles ← this repository
├── 20-29_praxis/
└── 30-39_media/
    ├── 31_text				# 30-39_media/31_text → /mnt/valus/31_text
    ├── 32_audio			# 30-39_media/32_audio → /mnt/valus/32_audio
    ├── 33_images			# 30-39_media/33_images → /mnt/valus/33_images
    ├── 34_video			# 30-39_media/34_video → /mnt/phaedra/34_video
    └── 35_video-games/
        ├── games-library	# 35_video-games/games-library → /mnt/valus/35_video-games/games-library
        └── steam			# 35_video-games/steam → /mnt/phaedra/35_video-games/SteamLibrary
```

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

## ｕｓａｇｅ

```bash
sudo bbit    # disk cleanup — dnf cache + thumbnails + journal (uses BleachBit)
tg           # topgrade — update everything (dnf/flatpak/cargo/…)
```

## ｂｏｏｔｓｔｒａｐ

```
./script/bootstrap
check_deps          # inotify-tools, git
link_file           # backs up overwritten files → ~/.dotfiles-backup/
link_dotfiles       # bash/*.symlink → ~/.<name>
link_config         # config/* → ~/.config/
link_bin            # bin/* → ~/bin/, chmod +x
link_systemd        # systemd/* → ~/.config/systemd/user/
enable_units        # daemon-reload, enable --now
setup_links         # hdd symlinks into strata
```