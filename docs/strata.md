# ｓｔｒａｔａ

strata is a personal organization system adapted from [johnny decimal](https://johnnydecimal.com/). it keeps his core idea: numbers divide everything into areas, categories, and ids. every item has a unique, predictable location.

- **areas** are the broad top-level directories, each spanning ten numbers (`10–19`, `20–29`, `30–39`, etc).
- **categories** live inside areas (`11`, `12`, `13`, etc).
- **ids** identify individual items inside a category (`11.01`, `11.02`, `11.03`, etc).

where strata departs from johnny decimal is in how it divides the top level. instead of grouping by topic, its three areas follow three roles a file can play: **infrastructure**, **creation**, and **collection**.

- **system** holds the foundation: how everything is set up, documented, and kept running.
- **praxis** holds the work: what you build, write, and design.
- **media** holds the archive: what you gather and preserve.

## ｔｒｅｅ

```
~/strata/
├── 00_index.md
├── 10-19_system/
│   ├── 11_personal
│   ├── 12_professional
│   ├── 13_system-config          ← this repo (dotfiles) lives here
│   ├── 14_backups
│   ├── 15_self-hosted
│   ├── 16_inbox
│   └── 17_archive
├── 20-29_praxis/
│   ├── 21_vault
│   ├── 22_visual-design
│   ├── 23_video-production
│   └── 24_development
└── 30-39_media/
    ├── 31_text                    ← local on the home btrfs subvolume
    ├── 32_audio                   → /mnt/valus/32_audio
    ├── 33_images                  ← local on the home btrfs subvolume
    ├── 34_video                   → /mnt/phaedra/34_video
    └── 35_video-games
        ├── games-library          → /mnt/valus/35_video-games/games-library
        └── steam                  → /mnt/phaedra/35_video-games/SteamLibrary
```

most media lives on external drives; `31_text` and `33_images` are now local and
canonical after being moved off valus. links are created by
`run_setup-storage.sh.tmpl`:

| category | source location |
|----------|-----------------|
| 31_text, 33_images | local: `~/strata/30-39_media/{31_text,33_images}` |
| 32_audio | → `/mnt/valus/32_audio` |
| 34_video | → `/mnt/phaedra/34_video` |
| 35_video-games | local directory; `games-library/` → valus, `steam/` → phaedra |

## ｘｄｇ　ｕｓｅｒ　ｄｉｒｓ

`~/.config/user-dirs.dirs` is managed by chezmoi and maps Documents → `31_text`,
Music → `32_audio`, Pictures → `33_images`, and Videos → `34_video`.
`~/.config/user-dirs.conf` sets `enabled=False`, so a missing drive does not cause
the session updater to reset those paths to `$HOME`. Videos stays mapped while
phaedra is absent; the path becomes usable again when the drive returns.

## ｃｏｎｖｅｎｔｉｏｎｓ

- ids are two digits; groups own the whole ten range (`11–17` inside `10–19`)
- a category may hold a `00_index.*` describing its contents; the top-level
  index is `~/strata/00_index.md`
- `31_text` holds text/books and Zotero linked attachments; the local tree is canonical
- `35_video-games` keeps game repos in `games-library/` and `steam/`

## ｉｎｄｅｘ　ｆｉｌｅｓ

`00_index.md` lives at `~/strata/`. update [`strata.md`](strata.md) first when the tree
changes, then refresh the index. other `00_index.*` files are optional per category.
