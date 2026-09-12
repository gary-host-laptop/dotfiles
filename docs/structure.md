# ｓｔｒｕｃｔｕｒｅ

the chezmoi source dir is `strata/` (set via `.chezmoiroot`). chezmoi naming conventions: `dot_` → `.`, `private_` → 600 perms, `executable_` → 755, `.tmpl` → rendered as Go template.

```
dotfiles/
├── .chezmoiroot
├── README.md LICENSE .gitignore
├── docs/
└── strata/                             # chezmoi source root
    ├── private_dot_bashrc.tmpl         # ~/.bashrc
    ├── private_dot_bash_profile        # ~/.bash_profile
    ├── private_dot_profile.tmpl        # ~/.profile
    ├── private_dot_gitconfig           # ~/.gitconfig
    ├── dot_gemrc.tmpl                  # ~/.gemrc
    ├── dot_bash/
    │   ├── aliases.bash                # shell aliases
    │   ├── exports.bash                # env vars
    │   ├── eza-colors                  # EZA_COLORS value (single source)
    │   ├── fedora-specific.bash        # fedora-only shell setup
    │   ├── nixos-specific.bash         # nixos stub
    │   └── drift.bash                  # idle screensaver hook
    ├── dot_config/
    │   ├── environment.d/
    │   │   └── 90-user.conf            # session PATH + XDG roots (systemd --user)
    │   ├── systemd/user/               # move-media, wallpaper, wallpaper.timer
    │   ├── nushell/                    # config.nu + env.nu (normalize only)
    │   ├── ghostty/                    # terminal config + custom css
    │   ├── zellij/                     # multiplexer config + tokyo night theme
    │   ├── kitty/                      # kitty terminal config
    │   ├── helix/                      # editor config + theme
    │   ├── starship.toml               # prompt
    │   ├── yazi/                       # file manager
    │   ├── fastfetch/                  # system info + logo
    │   ├── bat/                        # syntax highlighter + tokyo night theme
    │   ├── lazygit/                    # git tui + tokyo night theme
    │   ├── superfile/                  # file manager config + tokyonight theme
    │   ├── zoxide.nu                   # zoxide nushell integration
    │   ├── mpd/                        # music player daemon
    │   ├── flameshot/                  # screenshot tool
    │   ├── calibre/                    # ebook manager
    │   ├── vlc/                        # video player
    │   ├── superseedr/                 # torrent client
    │   ├── antimicrox/                 # gamepad mapper
    │   └── gtk-3.0/bookmarks.tmpl      # nautilus bookmarks
    ├── dot_var/
    │   ├── app/dev.zed.Zed/            # zed editor + sevastolink theme
    │   └── app/org.nicotine_plus.Nicotine/ # nicotine+ config (password templated)
    ├── dot_aMule/                      # amule config (KAD key templated)
    ├── dot_local/bin/                  # ~/.local/bin/ scripts
    └── .chezmoiscripts/
        ├── run_onchange_install-packages.sh.tmpl   # dnf, flatpak, cargo
        ├── run_onchange_enable-units.sh            # systemd daemon-reload + enable
        ├── run_once_setup-xdg.sh.tmpl              # xdg dirs, cursor, fonts
        ├── run_once_setup-storage.sh.tmpl          # hdd symlinks into strata
        └── run_once_generate-nushell-init.sh.tmpl  # starship/zoxide for nushell
```
