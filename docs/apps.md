# ａｐｐｓ

reference doc for all installed and evaluated applications.
essential apps are installed by `run_onchange_install-packages.sh.tmpl`.

## ｃｌｉ　/　ｔｕｉ　ｔｏｏｌｓ

### ｅｓｓｅｎｔｉａｌ

| app | package manager | category | id / notes |
|-----|-----------------|----------|------------|
| bat | dnf | utilities | cat replacement |
| backup | bin | utilities | essentials snapshot → `~/strata/10-19_system/14_backups/` (chezmoi.toml, ssh, beets, firefox logins+bookmarks, fstab) — see `docs/backup.md` |
| bleachbit | rpm (upstream manual) | utilities | cache/disk cleaner — `sudo bbit`; native 6.0.3 fc44 noarch rpm (upstream), fedora repo stale at 4.6.0; manual updates |
| btop | dnf | utilities | system monitor — crashes on AMD APUs if rocm-smi is installed |
| clipclear | bin | utilities | wipes all live X11+Wayland clipboard selections (`wl-copy --clear` + `xsel -c`) — clipboards here are RAM-only, so clearing actually deletes the data |
| croft | cargo | dev | rust toolchain manager — crates.io `croft-software` |
| drift | go | utilities | idle terminal screensaver — shells out via `dot_bash/drift.bash` (DRIFT_TIMEOUT=120); config at `dot_config/drift/config.toml` (tokyo-night theme) |
| eza | dnf | utilities | ls replacement |
| glow | dnf (charm repo) | utilities | markdown reader CLI — `glow file.md` |
| helix | dnf | dev | terminal editor |
| lazygit | dnf (dejan/lazygit copr) | dev | |
| rmpc | cargo | media | terminal mpd client — `mpc`-style TUI for the mpd daemon; config at `dot_config/rmpc/` (tokyo-night theme); reads mpd.conf's localhost:6600 |
| starship | dnf (atim/starship copr) | utilities | shell prompt |
| superfile | install script | utilities | spf — https://superfile.dev/install.sh; standalone file manager |
| superseedr | cargo | internet | TUI bittorrent client — downloads land in `~/strata/10-19_system/16_inbox` (move-media picks them up); `settings.toml` tracked, runtime state ignored (see `.chezmoiignore`) |
| topgrade | cargo | dev | multi-tool updater — `tg` alias; config at `dot_config/topgrade.toml.tmpl` |
| yank | dnf | utilities | terminal output → clipboard picker — dnf ships `/usr/bin/yank-cli` (upstream rename); `aliases.bash` weds it to `wl-copy`; `yank -- CMD` overrides |
| zellij | cargo-binstall | dev | terminal multiplexer — `cargo binstall zellij`; needs >=0.45 for kitty graphics (ghostty) |
| zoxide | cargo | dev | smarter `cd` — init in `dot_bash/fedora-specific.bash` |

### ｐｒｏｂａｔｉｏｎａｒｙ

| app | package manager | category | notes |
|-----|-----------------|----------|-------|
| yazi | gh release | dev | file manager — kitty image preview via `KgpOld`; superfile keeps the essential slot |

## ｇｕｉ　ａｐｐｌｉｃａｔｉｏｎｓ

### ｅｓｓｅｎｔｉａｌ

| app | package manager | category | flatpak id / notes |
|-----|-----------------|----------|--------------------|
| amule | manual | internet | org.amule.aMule — eD2k/Kad p2p client; flathub submission pending — install from https://amule-org.github.io/download (AppImage/.flatpak); config tracked `dot_aMule/amule.conf.tmpl`, KAD key via `[data.amule]` |
| anki | flatpak | productivity | net.ankiweb.Anki |
| blanket | flatpak | media | com.rafaelmardojai.Blanket |
| calibre | dnf | productivity | config subset tracked `dot_config/calibre/` (incl. OpenLibraryPlus plugin, templated library/db paths) |
| chromium | flatpak | internet | org.chromium.Chromium |
| element | flatpak | internet | im.riot.Riot |
| euphonica | flatpak | media | io.github.htkhiem.Euphonica — music client for mpd |
| firefox | dnf | internet | |
| flameshot | dnf | utilities | config + autostart tracked (save path templated) |
| flatseal | flatpak | utilities | com.github.tchx84.Flatseal |
| gimp | flatpak | creative | org.gimp.GIMP |
| ghostty | dnf (scottames/ghostty copr) | utilities | |
| inkscape | flatpak | creative | org.inkscape.Inkscape |
| kdenlive | dnf | creative | |
| keepassxc | flatpak | utilities | org.keepassxc.KeePassXC — config tracked `dot_config/keepassxc/keepassxc.ini.tmpl` |
| kitty | dnf | utilities | terminal — full `kitty.conf` tracked (plain), no machine-specific bits |
| localsend | flatpak | utilities | org.localsend.localsend_app |
| musicbrainz picard | flatpak | media | org.musicbrainz.Picard |
| nicotine+ | flatpak | internet | org.nicotine_plus.Nicotine — soulseek p2p; config tracked, password via `[data.nicotine]` (see README multi-machine) |
| obsidian | flatpak | productivity | md.obsidian.Obsidian |
| pdf arranger | flatpak | productivity | com.github.jeromerobert.pdfarranger |
| qbittorrent | flatpak | internet | org.qbittorrent.qBittorrent |
| retroarch | flatpak | games | org.libretro.RetroArch |
| spruce | flatpak | utilities | io.github.shonubot.Spruce |
| steam | rpm | games | steampowered.com |
| stremio | flatpak | internet | com.stremio.Stremio |
| tenacity | flatpak | media | org.tenacityaudio.Tenacity |
| thunderbird | flatpak | internet | org.mozilla.Thunderbird |
| tor browser | flatpak | internet | org.torproject.torbrowser-launcher |
| vlc | dnf | media | config trimmed to custom keys → `dot_config/vlc/vlcrc` (19 keys) |

### ｐｒｏｂａｔｉｏｎａｒｙ

currently evaluating — not in install script.

| app | package manager | category | notes |
|-----|-----------------|----------|-------|
| apostrophe | flatpak | productivity | org.gnome.gitlab.somas.Apostrophe — markdown editor |
| cine | flatpak | media | io.github.diegopvlk.Cine — screenshots |
| clapper | flatpak | media | no-titlebar video player |
| extensionmanager | flatpak | utilities | com.mattjakeman.ExtensionManager — GNOME extensions |
| gnome-extensions | flatpak | utilities | org.gnome.Extensions |
| gopeed | flatpak | internet | fast download manager |
| imageflow | flatpak | media | image batch processing |
| mission center | flatpak | utilities | system monitor |
| qview | flatpak | utilities | lightweight image viewer |
| readest | flatpak | internet | com.bilingify.readest — ebook reader |
| refine | flatpak | media | page.tesk.Refine |
| sitra | flatpak | internet | io.github.sitraorg.sitra — feed/reader |
| tokri | flatpak | internet | net.surajyadav.Tokri |
| tubeconverter | flatpak | internet | org.nickvision.tubeconverter |
| ytdl-gui | flatpak | internet | page.codeberg.impromptux.ytdl-gui |
| zen browser | flatpak | internet | firefox-based, evaluating |
| zed | flatpak | dev | dev.zed.Zed — too heavy for daily use, kept for occasional use; flatpak config + sevastolink theme tracked `dot_varr/app/dev.zed.Zed/` |

### ｔｒａｃｋｅｄ　ｇｕｉ　ｃｏｎｆｉｇｓ

managed by chezmoi (shortcuts aside, all in `~/strata/10-19_system/13_system-config/dotfiles`):

| app | source → target | notes |
|-----|-----------------|-------|
| autostart | `dot_config/autostart/` → `~/.config/autostart/` | Flameshot only; Mouzi + radia removed |
| calibre | `dot_config/calibre/` → `~/.config/calibre/` | `global.py.json`/`customize.py.json` templated (`library_path`, plugin zip path); excluded: `gui.json`, `caches/`, `metadata-sources-cache.json`, `icons-any.rcc`, viewer annots |
| flameshot | `dot_config/flameshot/flameshot.ini.tmpl` (save path templated) | |
| gtk bookmarks | `dot_config/gtk-3.0/bookmarks.tmpl` | nautilus sidebar |
| keepassxc | `dot_config/keepassxc/keepassxc.ini.tmpl` | native config (app runs via flatpak) — CompactMode, monochrome tray, 16-word pass generator, idle lock; KeeShare identity set to `Own=""` (unused feature — KeePassXC regenerates) |
| kitty | `dot_config/kitty/kitty.conf` → `~/.config/kitty/kitty.conf` | plain copy, no machine-specific bits |
| mimeapps | `dot_config/mimeapps.list` → `~/.config/mimeapps.list` | zed default editor, loupe images, vlc video |
| aMule | `dot_aMule/amule.conf.tmpl` → `~/.aMule/amule.conf` | `CryptoKadUDPKey` scrubbed → `[data.amule]`; `cryptkey.dat`/`.met`/bak excluded (runtime) |
| nicotine+ | `dot_varr/app/org.nicotine_plus.Nicotine/.../config.tmpl` → `~/.var/.../nicotine/config` | plaintext `passw` scrubbed → `[data.nicotine]` |
| vlc | `dot_config/vlc/vlcrc` → `~/.config/vlc/vlcrc` | trimmed to 19 non-default keys |
| zed | `dot_varr/app/dev.zed.Zed/config/zed/` → `~/.var/app/dev.zed.Zed/config/zed/` | settings.json + sevastolink theme |

**credentials** are never stored in the repo — values live in each machine's `~/.config/chezmoi/chezmoi.toml` (`[data.amule]`, `[data.nicotine]`), and render via `index`/`with` fallbacks so a fresh clone degrades to neutered values. see README "multi-machine".

### broken / removed

- **radia** — removed (hopflight alpha voice-assistant); deleted `~/.local/bin/radia`, `~/.config/radia/`, autostart entry
- **mouzi** — removed; deleted autostart entry + `/usr/bin/mouzi`

## ｓｅｌｆｈｏｓｔｅｄ　／　ｓｅｒｖｅｒｓ

### ｅｓｓｅｎｔｉａｌ　（ｄｅｐｌｏｙｅｄ）

from `~/strata/10-19_system/15_self-hosted/`.

| name | category | description |
|------|----------|-------------|
| 4get | metasearch proxy | aggregates results from multiple search engines behind a privacy-friendly interface |
| arr | media automation | *arr stack — Radarr + Sonarr + Bazarr + Prowlarr + qBittorrent (movies/TV/subs/indexers/torrents) |
| bindery | ebook/audiobook manager | monitors authors, downloads and organises books into the library |
| degoog | metasearch engine | searches multiple engines and merges results |
| glance | dashboard | information dashboard with RSS, bookmarks, calendar, weather, news |
| grimmory | ebook library manager | digital library for ebooks/comics/audiobooks with metadata + reader + OPDS |
| invidious | youtube frontend proxy | ad/tracker-free alternative youtube frontend |
| jellyfin | media server | streams video media to devices |
| karakeep | bookmark manager | read-it-later — saves links, bookmarks, notes, full-text search |
| linkwarden | bookmark manager | collaborative bookmark collection/organisation/sharing |
| maintenance | media library maintenance | MuxArr (dedupe) + CleanupArr (cleanup) |
| miniflux | RSS reader | minimal fast RSS/Atom feed reader |
| monbooru | image gallery | booru-style tag-based image gallery with auto-tagging |
| muhomu | personal dashboard | customisable new-tab page — bookmarks, notes, quotes, RSS, stats |
| mylar3 | comics download manager | automated comic-book (CBR/CBZ) download + library manager |
| navidrome | music streaming server | Subsonic-compatible music server |
| pihole | DNS/adblock | network-wide DNS sinkhole + local DNS/DHCP |
| portainer | container management | web UI for Docker containers/images/volumes/stacks |
| questarr | game download manager | *arr-inspired video game download manager |
| radicale | CalDAV/CardDAV server | hosts calendars and contacts |
| romm | ROM library manager | retro game (ROM) library manager with IGDB metadata |
| shadowbroker | mesh/infonet dashboard | aggregates news, prediction markets, finance, Meshtastic radio data |
| vikunja | task manager | to-do/task management — kanban/list/tree |
| yarr | RSS reader | lightweight RSS/Atom feed reader |

plus a system-level music server:

| name | package manager | category | notes |
|------|-----------------|----------|-------|
| mpd | dnf | media server | music daemon served to euphonica; config at `dot_config/mpd/mpd.conf` |

## ｍａｎｕａｌ　ｉｎｓｔａｌｌｓ

these require manual download/setup — not automated in `run_onchange_install-packages.sh.tmpl`.

| app | url | notes |
|-----|-----|-------|
| firefox nightly | https://www.mozilla.org/en-US/firefox/channel/desktop/ | no flatpak/dnf option |
| pokemmo | https://pokemmo.com | manual installer |
| shijima-qt | https://github.com/hv-chat/shijima-qt | ukagaka/shimeji runner |
| fightcade | https://www.fightcade.com | games |
| itch.io | https://itch.io/app | games |
| opencode | https://opencode.ai/install | CLI dev agent — installs to ~/.opencode/ |
| portmaster | https://safing.io/portmaster | network monitor |
