# ａｐｐｓ

reference doc for all installed and evaluated applications.
for automated installation of essentials, run `script/packages`.

## ｅｓｓｅｎｔｉａｌ

| app | package manager | category | flatpak id / notes |
|-----|-----------------|----------|--------------------|
| anki | flatpak | productivity | net.ankiweb.Anki |
| blanket | flatpak | media | com.rafaelmardojai.Blanket |
| bottom | dnf (atim/bottom copr) | utilities | |
| calibre | dnf | productivity | |
| chromium | flatpak | internet | org.chromium.Chromium |
| element | flatpak | internet | im.riot.Riot |
| euphonica | flatpak | media | io.github.htkhiem.Euphonica |
| firefox | flatpak | internet | org.mozilla.firefox |
| flameshot | dnf | utilities | |
| flatseal | flatpak | utilities | com.github.tchx84.Flatseal |
| gimp | flatpak | creative | org.gimp.GIMP |
| ghostty | dnf (scottames/ghostty copr) | utilities | |
| inkscape | flatpak | creative | org.inkscape.Inkscape |
| kdenlive | flatpak | creative | org.kde.kdenlive |
| keepassxc | dnf | utilities | |
| localsend | flatpak | utilities | org.localsend.localsend_app |
| musicbrainz picard | flatpak | media | org.musicbrainz.Picard |
| nicotine+ | flatpak | internet | org.nicotine_plus.Nicotine |
| obsidian | flatpak | productivity | md.obsidian.Obsidian |
| pdf arranger | flatpak | productivity | com.github.jeromerobert.pdfarranger |
| qbittorrent | dnf | internet | |
| retroarch | flatpak | games | org.libretro.RetroArch |
| spruce | flatpak | utilities | io.github.shonubot.Spruce |
| starship | dnf (atim/starship copr) | utilities | |
| steam | rpm | games | steampowered.com |
| stremio | flatpak | internet | com.stremio.Stremio |
| tenacity | flatpak | media | org.tenacityaudio.Tenacity |
| thunderbird | flatpak | internet | org.mozilla.Thunderbird |
| tor browser | flatpak | internet | org.torproject.torbrowser-launcher |
| veracrypt | rpm | utilities | veracrypt.fr/en/Downloads.html |
| vlc | flatpak | media | org.videolan.VLC |
| zed | rpm | dev | zed.dev |

## ｍａｎｕａｌ　ｉｎｓｔａｌｌｓ

these require manual download/setup — not automated in `script/packages`.

| app | url | notes |
|-----|-----|-------|
| firefox nightly | https://www.mozilla.org/en-US/firefox/channel/desktop/ | no flatpak/dnf option |
| pokemmo | https://pokemmo.com | manual installer |
| readest | https://readest.com | appimage |
| shijima-qt | https://github.com/hv-chat/shijima-qt | ukagaka/shimeji runner |
| fightcade | https://www.fightcade.com | games |
| itch.io | https://itch.io/app | games |
| portmaster | https://safing.io/portmaster | network monitor |

## ｐｒｏｂａｔｉｏｎａｒｙ

currently evaluating — not in install script.

| app | package manager | category | notes |
|-----|-----------------|----------|-------|
| clapper | flatpak | media | no-titlebar video player |
| gopeed | flatpak | internet | fast download manager |
| imageflow | flatpak | media | image batch processing |
| mission center | flatpak | utilities | system monitor |
| qview | flatpak | utilities | lightweight image viewer |
| zen browser | flatpak | internet | firefox-based, evaluating |

## ｎｏｔｅｓ

### music
settled on euphonica + mpd. requires music library cleanup before full use.
mpd config tracked in dotfiles at `config/mpd/mpd.conf`.

### video players
vlc is the reliable fallback but prefer no-titlebar style players.
trying: clapper.

### image viewers
evaluating qview as a lightweight option.

### removed
- damask — unused
- elisa, lollypop — replaced by euphonica
- kando — not using
- zed — too heavy for daily use, kept for occasional use
