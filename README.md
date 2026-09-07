# ｄｏｔｆｉｌｅｓ

personal system configuration managed by [chezmoi](https://www.chezmoi.io/), organized within a [johnny decimal](https://johnnydecimal.com/) inspired strata file system.

supports multiple machines via templates — fedora (current) and nixos (planned).

## ｓｔｒｕｃｔｕｒｅ

```
dotfiles/
├── private_dot_bashrc.tmpl             # ~/.bashrc (template: machine-specific init)
├── private_dot_bash_profile            # ~/.bash_profile
├── private_dot_profile                 # ~/.profile
├── private_dot_gitconfig               # ~/.gitconfig
├── dot_bash/
│   ├── aliases.bash                    # shell aliases (shared)
│   ├── drift.bash                      # drift idle screensaver shell hook
│   ├── exports.bash                    # PATH, env vars (shared)
│   └── fedora-specific.bash            # starship, zoxide, opencode (fedora only)
├── dot_config/                         # ~/.config/ — app configs
│   ├── systemd/user/                   # move-media, wallpaper, wallpaper.timer
│   ├── kitty/ mimeapps.list autostart/ # terminal, default apps, autostart
│   ├── flameshot/ vlc/ calibre/        # screenshots, video, ebook manager
│   └── gtk-3.0/bookmarks.tmpl          # nautilus bookmarks (templated home)
├── dot_varr/                           # ~/.var/ — flatpak app configs
│   └── app/dev.zed.Zed/                # zed editor config + sevastolink theme
│   └── app/org.nicotine_plus.Nicotine/ # nicotine+ p2p config (passw templated)
├── dot_aMule/                          # ~/.aMule/ — amule.conf (KAD key templated)
├── bin/                                # ~/bin/ scripts — executable_ prefix → 755
├── run_onchange_install-packages.sh.tmpl   # package install (re-runs on change)
├── run_once_setup-xdg.sh.tmpl          # xdg dirs + theming (one-time)
├── run_once_setup-storage.sh.tmpl      # hdd symlinks (one-time)
├── run_once_generate-nushell-init.sh.tmpl  # starship/zoxide for nushell
├── run_onchange_enable-units.sh        # systemd daemon-reload + enable
└── docs/
    ├── apps.md                         # app inventory + install notes
    ├── backup.md                       # essentials-backup inventory + restore
    ├── fstab.fedora                    # /etc/fstab reference for reinstalls
    ├── hardware.md                     # machine specs + drive layout
    └── strata.md                       # johnny-decimal category/tree/index docs
```

## ｓｔｒａｔａ

full breakdown (categories, tree, drive mapping, index files): [`docs/strata.md`](docs/strata.md).

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
# 2. run run_onchange_install-packages.sh (dnf, flatpak, cargo)
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

templates (`.tmpl` files) use `{{ if eq (.machine | default "fedora") "..." }}` to render different configs per machine (`| default "fedora"` keeps working even if `machine` is unset).

on each machine, create `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
machine = "fedora"   # or "nixos"

# per-machine values for templated secrets — never stored in the repo
[data.amule]
kadUdpKey = "0"            # optional; omitted → aMule regenerates (0)
[data.nicotine]
password = "..."           # nicotine+ soulseek password; omitted → ""
```

chezmoi compiles templates on each machine, so the same source produces different outputs. missing `amule`/`nicotine` data degrades to neutered values (`0` / `""`) so the repo still applies on a fresh machine.

## ｂｏｏｔｓｔｒａｐ　ｆｌｏｗ

```
chezmoi init --apply
├── run_onchange_install-packages.sh    # dnf, copr, flatpak, cargo, rust
├── run_once_setup-xdg.sh           # xdg user dirs, cursor, fonts
├── run_once_setup-storage.sh       # hdd symlinks into strata
├── run_once_generate-nushell-init.sh  # starship/zoxide init for nushell
└── run_onchange_enable-units.sh   # systemd daemon-reload + enable
```
