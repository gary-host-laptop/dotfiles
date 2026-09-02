# ａｐｐｓ

reference doc for all installed and evaluated applications.
essential apps are installed by `script/packages`.

## ｃｌｉ　/　ｔｕｉ　ｔｏｏｌｓ

### ｅｓｓｅｎｔｉａｌ

| app | package manager | category | id / notes |
|-----|-----------------|----------|------------|
| bat | dnf | utilities | cat replacement |
| bleachbit | rpm (upstream manual) | utilities | cache/disk cleaner — `sudo bbit`; native 6.0.3 fc44 noarch rpm (upstream), fedora repo stale at 4.6.0; manual updates |
| btop | dnf | utilities | system monitor — crashes on AMD APUs if rocm-smi is installed |
| croft | cargo | dev | rust toolchain manager — crates.io `croft-software` |
| eza | dnf | utilities | ls replacement |
| glow | dnf (charm repo) | utilities | markdown reader CLI — `glow file.md` |
| helix | dnf | dev | terminal editor |
| lazygit | dnf (dejan/lazygit copr) | dev | |
| starship | dnf (atim/starship copr) | utilities | shell prompt |
| superfile | install script | utilities | spf — https://superfile.dev/install.sh; standalone file manager |
| topgrade | cargo | dev | multi-tool updater — `tg` alias; config at `config/topgrade.toml` |
| zellij | cargo-binstall | dev | terminal multiplexer — `cargo binstall zellij`; needs >=0.45 for kitty graphics (ghostty) |
| zoxide | cargo | dev | smarter `cd` — init in `bash/bashrc.symlink` |

### ｐｒｏｂａｔｉｏｎａｒｙ

| app | package manager | category | notes |
|-----|-----------------|----------|-------|
| yazi | gh release | dev | file manager — kitty image preview via `KgpOld`; superfile keeps the essential slot |

## ｇｕｉ　ａｐｐｌｉｃａｔｉｏｎｓ

### ｅｓｓｅｎｔｉａｌ

| app | package manager | category | flatpak id / notes |
|-----|-----------------|----------|--------------------|
| amule | flatpak | internet | org.amule.aMule — eD2k/Kad p2p client |
| anki | flatpak | productivity | net.ankiweb.Anki |
| blanket | flatpak | media | com.rafaelmardojai.Blanket |
| calibre | dnf | productivity | |
| chromium | flatpak | internet | org.chromium.Chromium |
| element | flatpak | internet | im.riot.Riot |
| euphonica | flatpak | media | io.github.htkhiem.Euphonica — music client for mpd |
| firefox | dnf | internet | |
| flameshot | dnf | utilities | |
| flatseal | flatpak | utilities | com.github.tchx84.Flatseal |
| gimp | flatpak | creative | org.gimp.GIMP |
| ghostty | dnf (scottames/ghostty copr) | utilities | |
| inkscape | flatpak | creative | org.inkscape.Inkscape |
| kdenlive | dnf | creative | |
| keepassxc | flatpak | utilities | org.keepassxc.KeePassXC |
| localsend | flatpak | utilities | org.localsend.localsend_app |
| musicbrainz picard | flatpak | media | org.musicbrainz.Picard |
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
| vlc | dnf | media | |

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
| zed | flatpak | dev | dev.zed.Zed — too heavy for daily use, kept for occasional use |

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
| mpd | dnf | media server | music daemon served to euphonica; config at `config/mpd/mpd.conf` |

## ｍａｎｕａｌ　ｉｎｓｔａｌｌｓ

these require manual download/setup — not automated in `script/packages`.

| app | url | notes |
|-----|-----|-------|
| firefox nightly | https://www.mozilla.org/en-US/firefox/channel/desktop/ | no flatpak/dnf option |
| pokemmo | https://pokemmo.com | manual installer |
| shijima-qt | https://github.com/hv-chat/shijima-qt | ukagaka/shimeji runner |
| fightcade | https://www.fightcade.com | games |
| itch.io | https://itch.io/app | games |
| opencode | https://opencode.ai/install | CLI dev agent — installs to ~/.opencode/ |
| portmaster | https://safing.io/portmaster | network monitor |

## ｒｅｍｏｖｅｄ

- damask — unused
- elisa, lollypop — replaced by euphonica
- kando — not using (uninstalled)
- mpc — dropped; euphonica's GUI handles mpd control
