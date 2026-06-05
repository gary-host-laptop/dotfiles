# apps

reference doc for all installed and evaluated applications.
for automated installation of essentials, run `script/packages`.

## essential

| app | package manager | category | flatpak id / notes |
|-----|-----------------|----------|--------------------|
| anki | flatpak | productivity | net.ankiweb.Anki |
| blanket | flatpak | media | com.rafaelmardojai.Blanket |
| calibre | dnf | productivity | |
| chromium | flatpak | internet | org.chromium.Chromium |
| damask | flatpak | utilities | io.github.dgsasha.Damask |
| element | flatpak | internet | im.riot.Riot |
| firefox | flatpak | internet | org.mozilla.firefox |
| flameshot | dnf | utilities | |
| flatseal | flatpak | utilities | com.github.jeromerobert.pdfarranger |
| gimp | flatpak | creative | org.gimp.GIMP |
| kdenlive | flatpak | creative | org.kde.kdenlive |
| keepassxc | dnf | utilities | |
| musicbrainz picard | flatpak | media | org.musicbrainz.Picard |
| nicotine+ | dnf | internet | |
| obsidian | flatpak | productivity | md.obsidian.Obsidian |
| pdf arranger | flatpak | productivity | com.github.jeromerobert.pdfarranger |
| qbittorrent | dnf | internet | |
| retroarch | flatpak | games | org.libretro.RetroArch |
| spruce | flatpak | utilities | org.gnome.Spruce |
| steam | rpm | games | steampowered.com |
| stremio | flatpak | internet | com.stremio.Stremio |
| tenacity | flatpak | media | org.tenacityaudio.Tenacity |
| thunderbird | flatpak | internet | org.mozilla.Thunderbird |
| veracrypt | rpm | utilities | veracrypt.fr/en/Downloads.html |
| vlc | flatpak | media | org.videolan.VLC |
| zed | rpm | dev | zed.dev |

## manual installs

these require manual download/setup — not automated in `script/packages`.

| app | url | notes |
|-----|-----|-------|
| firefox nightly | https://www.mozilla.org/en-US/firefox/channel/desktop/ | no flatpak/dnf option |
| pokemmo | https://pokemmo.com | manual installer |
| readest | https://readest.com | appimage |
| shijima-qt | https://github.com/hv-chat/shijima-qt | ukagaka/shimeji runner |
| tokri | — | tbd |
| fightcade | https://www.fightcade.com | games |
| itch.io | https://itch.io/app | games |
| kando | https://kando.menu | pie menu — evaluating |
| portmaster | https://safing.io/portmaster | network monitor |

## probationary

currently evaluating — not in install script.

| app | package manager | category | notes |
|-----|-----------------|----------|-------|
| clapper | flatpak | media | no-titlebar video player |
| elisa | flatpak | media | music player candidate |
| lollypop | flatpak | media | music player candidate |
| qview | flatpak | utilities | lightweight image viewer |

## notes

### music players
currently evaluating — none fully satisfactory yet.
trying: elisa, lollypop.
looking for: good library management, scrobbling, clean ui.

### video players
vlc is the reliable fallback but prefer no-titlebar style players.
trying: clapper.

### image viewers
evaluating qview as a lightweight option.
