# ｄｏｔｆｉｌｅｓ

personal system configuration managed by [chezmoi](https://www.chezmoi.io/), organized within a [johnny decimal](https://johnnydecimal.com/) inspired strata file system.

supports multiple machines via templates — fedora (current) and nixos (planned).

## ｓｔｒｕｃｔｕｒｅ

```
dotfiles/
├── chezmoi.yaml                        # source dir config
├── private_dot_bashrc.tmpl             # ~/.bashrc (template: machine-specific init)
├── private_dot_bash_profile            # ~/.bash_profile
├── private_dot_profile                 # ~/.profile
├── private_dot_gitconfig               # ~/.gitconfig
├── dot_bash/
│   ├── aliases.bash                    # shell aliases (shared)
│   ├── exports.bash                    # PATH, env vars (shared)
│   └── fedora-specific.bash            # starship, zoxide, opencode (fedora only)
├── dot_config/                         # ~/.config/
│   ├── btop/btop.conf.tmpl             # template: theme differs per machine
│   ├── topgrade.toml.tmpl              # template: [linux] vs [nix] section
│   ├── bat/                            # shared
│   ├── helix/                          # shared
│   ├── starship.toml                   # shared
│   ├── glow/                           # shared
│   ├── lazygit/                        # shared
│   ├── superfile/                      # shared
│   ├── fastfetch/                      # shared
│   ├── yazi/                           # shared
│   ├── zellij/                         # shared
│   ├── ghostty/                        # fedora only
│   ├── environment.d/                  # fedora only
│   ├── nushell/                        # fedora only
│   ├── antimicrox/                     # fedora only
│   ├── mpd/                            # fedora only
│   └── systemd/user/                   # fedora only
│       ├── move-media.service
│       ├── wallpaper.service
│       └── wallpaper.timer
├── bin/                                 # ~/bin/ scripts — executable_ prefix → 755
│   ├── executable_bbit                  # one-shot BleachBit cleanup
│   ├── executable_move-media.sh         # moves images from inbox + screenshots
│   ├── executable_strata-status         # disk usage overview
│   └── executable_wallpaper             # random wallpaper setter (GNOME)
├── run_once_install-packages.sh.tmpl   # package install (one-time)
├── run_once_setup-xdg.sh.tmpl          # xdg dirs + theming (one-time)
├── run_once_setup-storage.sh.tmpl      # hdd symlinks (one-time)
├── run_once_generate-nushell-init.sh.tmpl  # starship/zoxide for nushell
├── run_on_change_enable-units.sh       # systemd daemon-reload + enable
├── docs/
│   ├── apps.md                         # app inventory + install notes
│   └── hardware.md                     # machine specs + drive layout
├── README.md
└── LICENSE
```

## ｓｔｒａｔａ

```
~/strata/
├── 10-19_system/
│   └── 13_system-config/
│       ├── dotfiles/                   # 13_system-config/dotfiles ← this repository
│       └── nixos/                      # nixos system config (flake + home manager)
├── 20-29_praxis/
└── 30-39_media/
    ├── 31_text                         # 30-39_media/31_text → /mnt/valus/31_text
    ├── 32_audio                        # 30-39_media/32_audio → /mnt/valus/32_audio
    ├── 33_images                       # 30-39_media/33_images → /mnt/valus/33_images
    ├── 34_video                        # 30-39_media/34_video → /mnt/phaedra/34_video
    └── 35_video-games/
        ├── games-library               # 35_video-games/games-library → /mnt/valus/35_video-games/games-library
        └── steam                       # 35_video-games/steam → /mnt/phaedra/35_video-games/SteamLibrary
```

## ｆｒｅｓｈ　ｉｎｓｔａｌｌ

```bash
# install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"

# initialize — clones repo, applies configs, runs setup scripts
chezmoi init --source ~/strata/10-19_system/13_system-config/dotfiles --apply gary-host-laptop

# that's it. chezmoi will:
# 1. clone/sync this repo
# 2. run run_once_install-packages.sh (dnf, flatpak, cargo)
# 3. run run_once_setup-xdg.sh (user dirs, fonts, cursor)
# 4. run run_once_setup-storage.sh (hdd symlinks)
# 5. run run_once_generate-nushell-init.sh (starship/zoxide for nu)
# 6. apply all managed files to ~/
```

## ｕｓｉｎｇ　ｃｈｅｚｍｏｉ

```bash
chezmoi apply            # apply pending changes
chezmoi edit <file>      # edit a managed file (opens in $EDITOR)
chezmoi cd               # cd to the source directory
chezmoi diff             # see what would change
chezmoi status           # current state vs managed
chezmoi forget <file>    # stop managing a file
```

## ｍｕｌｔｉ‑ｍａｃｈｉｎｅ

templates (`.tmpl` files) use `{{ if eq .chezmoi.machine "..." }}` to render different configs per machine.

on each machine, create `~/.config/chezmoi/chezmoi.yaml`:

```yaml
# fedora:
machine: fedora

# nixos:
machine: nixos
```

chezmoi compiles templates on each machine, so the same source produces different outputs.

## ｂｏｏｔｓｔｒａｐ　ｆｌｏｗ

```
chezmoi init --apply
├── run_once_install-packages.sh    # dnf, copr, flatpak, cargo, rust
├── run_once_setup-xdg.sh           # xdg user dirs, cursor, fonts
├── run_once_setup-storage.sh       # hdd symlinks into strata
├── run_once_generate-nushell-init.sh  # starship/zoxide init for nushell
└── run_on_change_enable-units.sh   # systemd daemon-reload + enable
```
