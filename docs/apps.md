# ａｐｐｓ

reference doc for installed and evaluated applications. **essential** means a daily
driver; **probationary** means installed or evaluated, but not part of the core setup.
source paths live in [`structure.md`](structure.md); machine-local secrets and backups
in [`backup.md`](backup.md).

file managers: **Strata** is the GUI/default handler, **superfile** is the primary TUI,
and **yazi** is an evaluated TUI alternative.

last inventory pass: 2026-10-23 (`flatpak list --app`, `command -v`, `chezmoi managed`).

## ｃｌｉ　/　ｔｕｉ　ｔｏｏｌｓ

### ｅｓｓｅｎｔｉａｌ

| app | package manager | category | id / notes |
|-----|-----------------|----------|------------|
| bat | dnf | utilities | cat replacement — custom theme `dot_config/bat/themes/tokyonight_night.tmTheme` (folke/tokyonight); theme key is the *filename stem*, not the plist's internal `TokyoNight` name. Since 0.26 bat loads custom themes **only** via its binary asset cache (`~/.cache/bat/themes.bin`), so `bat cache --build` is mandatory (run by install-packages; re-run after any bat upgrade or bat hard-errors on the version-pinned cache) |
| backup | bin | utilities | essentials backup → `~/strata/10-19_system/14_backups/` (chezmoi.toml, ssh, beets, firefox cookies+bookmarks, fstab) — see `docs/backup.md` |
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
| superfile | install script | utilities | spf — https://superfile.dev/install.sh; primary TUI file manager alongside the GUI default, Strata |
| superseedr | cargo | internet | TUI bittorrent client — downloads land in `~/strata/10-19_system/16_inbox` (move-media picks them up); `settings.toml` tracked, runtime state ignored (see `.chezmoiignore`) |
| topgrade | cargo | dev | multi-tool updater — `tg` alias; config at `dot_config/topgrade.toml.tmpl` |
| yank | dnf | utilities | terminal output → clipboard picker — dnf ships `/usr/bin/yank-cli` (upstream rename); `aliases.bash` weds it to `wl-copy`; `yank -- CMD` overrides |
| zellij | cargo-binstall | dev | terminal multiplexer — `cargo binstall zellij`; needs >=0.45 for kitty graphics (ghostty) |
| zoxide | cargo | dev | smarter `cd` — init in `private_dot_bashrc.tmpl` |

### ｐｒｏｂａｔｉｏｎａｒｙ

| app | package manager | category | notes |
|-----|-----------------|----------|-------|
| yazi | gh release | dev | TUI file manager — kitty image preview via `KgpOld`; probationary alternative to superfile, with Strata as the GUI default |
| zotero | official tarball | productivity | reference manager — pinned `ZOTERO_VER` in install-packages (no usable dnf/copr/flatpak build: the flathub build sandboxes the data dir). Extracts to `~/.local/opt/Zotero-<ver>` behind a stable `~/.local/opt/Zotero` symlink, so upgrades keep the old version and rollback is a symlink flip. Launcher at `~/.local/bin/zotero` is plain and unmanaged; tracked `~/.zotero/zotero/profiles.ini` selects the pinned profile at `~/.config/zotero/profile` via `IsRelative=0`, so chezmoi owns `profiles.ini` + `prefs.js` (via `modify_private_prefs.js`); desktop entry/icons in `~/.local/share`. Data directory is `~/Zotero` (DB + storage); linked-attachment base is `~/strata/30-39_media/31_text/zotero`. ZotMoov 1.2.32 moves new connector downloads to `.../articles` as linked files. Attachments untracked; not covered by `14_backups` |

## ｇｕｉ　ａｐｐｌｉｃａｔｉｏｎｓ

### ｅｓｓｅｎｔｉａｌ

| app | package manager | category | flatpak id / notes |
|-----|-----------------|----------|--------------------|
| amule | manual | internet | org.amule.aMule — eD2k/Kad p2p client; flathub submission pending — install from https://amule-org.github.io/download (AppImage/.flatpak); config tracked `dot_aMule/modify_amule.conf.tmpl`, KAD key via `[data.amule]` |
| anki | flatpak | productivity | net.ankiweb.Anki |
| blanket | flatpak | media | com.rafaelmardojai.Blanket |
| calibre | dnf | productivity | config subset tracked `dot_config/calibre/` (incl. OpenLibraryPlus plugin, templated library/db paths) |
| chromium | flatpak | internet | org.chromium.Chromium |
| element | flatpak | internet | im.riot.Riot |
| euphonica | flatpak | media | io.github.htkhiem.Euphonica — music client for mpd |
| firefox | dnf | internet | profile pinned at `~/.mozilla/firefox/ghost-profile` via tracked `profiles.ini` + `installs.ini` (and updated `Profile Groups` store path); curated `user.js` and tracked `handlers.json` in the profile. Extensions are policy-managed from `strata/.chezmoitemplates/firefox-policies.json` via `/etc/firefox/policies/policies.json` (sudo; `normal_installed`, so they remain removable); install is pending in [#7](https://github.com/gary-host-laptop/dotfiles/issues/7). Cookies/logins/bookmarks/session are untracked; new-tab pins/wallpaper and extension internal settings are not restored |
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
| retroarch | dnf | games | native (retroarch + retroarch-assets from fedora repos) — cores fetched from https://buildbot.libretro.com/nightly/linux/x86_64/latest into `~/.config/retroarch/cores`; no flatpak installed; see tracked configs below |
| spruce | flatpak | utilities | io.github.shonubot.Spruce |
| steam | rpm | games | steampowered.com |
| strata | manual release | utilities | GUI file manager — Strata 1.1.0, `io.github.lgse.Strata`; default `inode/directory` handler. Install from https://github.com/lgse/strata or https://stratafiles.io/. Config tracked; runtime recent-apps unmanaged. See tracked configs below |
| stremio | flatpak | internet | com.stremio.Stremio |
| tenacity | flatpak | media | org.tenacityaudio.Tenacity |
| thunderbird | flatpak | internet | org.mozilla.thunderbird_esr |
| tor browser | flatpak | internet | org.torproject.torbrowser-launcher |
| vlc | dnf | media | app rewrites the whole rc; `dot_config/vlc/modify_vlcrc` enforces 19 custom keys |

### ｐｒｏｂａｔｉｏｎａｒｙ

currently evaluating — not in install script.

| app | package manager | category | notes |
|-----|-----------------|----------|-------|
| apostrophe | flatpak | productivity | org.gnome.gitlab.somas.Apostrophe — markdown editor |
| cine | flatpak | media | io.github.diegopvlk.Cine — screenshots |
| clapper | flatpak | media | no-titlebar video player |
| extensionmanager | flatpak | utilities | com.mattjakeman.ExtensionManager — GNOME extensions |
| foliate | flatpak | productivity | com.github.johnfactotum.Foliate — ebook viewer |
| gnome-extensions | flatpak | utilities | org.gnome.Extensions |
| gopeed | flatpak | internet | fast download manager |
| imageflow | flatpak | media | image batch processing |
| mission center | flatpak | utilities | io.missioncenter.MissionCenter — system monitor |
| pkvault | flatpak | games | io.github.chnapy.pkvault — Pokémon save storage/manipulation (PKHeX) |
| pods | flatpak | dev | com.github.marhkb.Pods — Podman container manager |
| qview | flatpak | utilities | lightweight image viewer |
| readest | flatpak | internet | com.bilingify.readest — ebook reader |
| refine | flatpak | media | page.tesk.Refine |
| rufin | flatpak | media | io.github.screwys.Rufin — native music player |
| sitra | flatpak | internet | io.github.sitraorg.sitra — feed/reader |
| tailor | flatpak | utilities | org.altlinux.Tailor — bootable drive writer |
| tokri | flatpak | internet | net.surajyadav.Tokri |
| parabolic | flatpak | internet | org.nickvision.tubeconverter — youtube downloader (formerly Tube Converter) |
| ytdl-gui | flatpak | internet | page.codeberg.impromptux.ytdl-gui |
| zen browser | flatpak | internet | app.zen_browser.zen — firefox-based, evaluating |
| zed | flatpak | dev | dev.zed.Zed — too heavy for daily use, kept for occasional use; flatpak config + sevastolink theme tracked `dot_var/app/dev.zed.Zed/` |

### ｔｒａｃｋｅｄ　ｇｕｉ　ｃｏｎｆｉｇｓ

managed by chezmoi (shortcuts aside, all in `~/strata/10-19_system/13_system-config/dotfiles/strata` — the `.chezmoiroot` source dir):

| app | source → target | notes |
|-----|-----------------|-------|
| autostart | `dot_config/autostart/` → `~/.config/autostart/` | Flameshot only |
| calibre | `dot_config/calibre/` → `~/.config/calibre/` | `global.py.json`/`customize.py.json` templated (`library_path`, plugin zip path); excluded: `gui.json`, `caches/`, `metadata-sources-cache.json`, `icons-any.rcc`, viewer annots |
| flameshot | `dot_config/flameshot/flameshot.ini.tmpl` (save path templated) | |
| gtk bookmarks | `dot_config/gtk-3.0/bookmarks.tmpl` | nautilus sidebar |
| keepassxc | `dot_config/keepassxc/keepassxc.ini.tmpl` | native config (app runs via flatpak) — CompactMode, monochrome tray, 16-word pass generator, idle lock; KeeShare identity set to `Own=""` (unused feature — KeePassXC regenerates) |
| kitty | `dot_config/kitty/kitty.conf` → `~/.config/kitty/kitty.conf` | plain copy, no machine-specific bits |
| strata | `dot_config/strata/private_settings.toml` → `~/.config/strata/settings.toml` | Strata file manager — Tokyo Night, browser density, previews, sidebar order; `private_` keeps the target 0600. `default_directory` is currently hardcoded to `/home/ghost_user/strata` (templating deferred — see [#5](https://github.com/gary-host-laptop/dotfiles/issues/5)); `~/.local/share/strata/recent-apps.toml` is runtime and unmanaged |
| mimeapps | unmanaged (`.chezmoiignore`) → `~/.config/mimeapps.list` | GNOME/flatpak owns it and rewrites it on every app install/removal — it added the Foliate epub entries itself, and tracking the file meant `chezmoi apply` would strip associations for installed apps. The desktop manages associations |
| aMule | `dot_aMule/modify_amule.conf.tmpl` → `~/.aMule/amule.conf` | `CryptoKadUDPKey` scrubbed → `[data.amule]`; `cryptkey.dat`/`.met`/bak excluded (runtime) |
| nicotine+ | `dot_var/app/org.nicotine_plus.Nicotine/.../nicotine/modify_private_config` → `~/.var/.../nicotine/config` | nicotine rewrites the whole config on exit and had accumulated app state no repo should own (search history, `[statistics]` counters, `[columns]` widths, window geometry), so it's managed by a `modify_` script instead of a template — guarantees 23 keys (Soulseek `server`/`login`/`passw`/`interface`/`portrange`/`upnp`/`upnp_interval`/`auto_connect_startup`/`autoaway`, plus the three `[transfers]` inbox/media dirs, `shared`, speed limits, `useupslots`/`uploadslots`, `limitby`/`queuelimit`/`filelimit`, `groupdownloads`/`groupuploads`) and passes everything else through — all of `[logging]`, `[ui]`, `[notifications]`, `[statistics]`, `[columns]`, `[searches]`, `[userinfo]`, `[interests]`, `[players]`, `[privatechat]`, `[words]`, `[urls]`, `[userbrowse]` stay app-owned. `private_` keeps it 0600 (it holds a plaintext `passw`); it's a `chezmoi:modify-template` (no `.tmpl` suffix) so `passw` still comes from `[data.nicotine]` |
| antimicrox | `dot_config/antimicrox/modify_antimicrox_settings.ini` → `~/.config/antimicrox/antimicrox_settings.ini` | app owns the whole ini, so it's managed by a `modify_` script (not a template): guarantees DisplayNames=0, last profile = `gamepad.gamecontroller.amgp` while preserving app-written keys (window pos/size) |
| retroarch | `dot_config/retroarch/modify_retroarch.cfg` → `~/.config/retroarch/retroarch.cfg` | retroarch rewrites the whole cfg on exit, so it's managed by a `modify_` script that only enforces key = "value" lines (drivers glcore renderer + `video_context_driver "x"`/`input_driver "x"` windowing+input, pipewire, ozone, ROM dirs in `~/.config/retroarch/...` form, `/usr/share/libretro/...` data) and leaves app-owned lines alone; per-core BIOS overrides `dot_config/retroarch/config/<Core>/<Core>.cfg.tmpl` → `~/.config/retroarch/config/<Core>/<Core>.cfg` (points `system_directory` at the RomM `bios/<system>` subdir); library config via `[data.retroarch]` falling back to the fedora mount; app-grid icon via `dot_local/share/icons/hicolor/scalable/apps/com.libretro.RetroArch.svg` (copied from `/usr/share/pixmaps`). The `"x"` context/input drivers force X11/XWayland so GNOME draws the titlebar — mutter has no `zxdg_decoration_manager_v1` and the fedora build appears not to be built with libdecor support, so native wayland would be borderless |
| vlc | `dot_config/vlc/modify_vlcrc` → `~/.config/vlc/vlcrc` | vlc rewrites the whole rc on exit, so it's managed by a `modify_` script that pins 19 non-default keys (sharpen, freetype fonts/OSD, marq/logo/audiobargraph positions, qt dark palette/privacy/autoresize, audio language, loop, single-instance, metadata network) section-aware and leaves the rest app-owned |
| zed | `dot_var/app/dev.zed.Zed/config/zed/` → `~/.var/app/dev.zed.Zed/config/zed/` | settings.json + sevastolink theme |

**credentials** are never stored in the repo — values live in each machine's `~/.config/chezmoi/chezmoi.toml` (`[data.amule]`, `[data.nicotine]`), and render via `index`/`with` fallbacks so a fresh clone degrades to neutered values. see README "multi-machine".

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
