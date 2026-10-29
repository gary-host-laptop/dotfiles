# ｓｔｒａｔａ

personal filesystem organized with a [johnny decimal](https://johnnydecimal.com/)-inspired
scheme: every folder gets a two-digit id, ids are grouped into ten-wide categories
(`10–19`, `20–29`, `30–39`), and each item has a unique, predictable location.

`docs/strata.md` is the canonical description — `~/strata/00_index.md` mirrors this
tree (drive layout: [`hardware.md`](hardware.md); backups: [`backup.md`](backup.md)).
this is the **strata filesystem**, not the [Strata file manager](apps.md).

## ｃａｔｅｇｏｒｉｅｓ

```
10-19_system       the machine you live in
20-29_praxis       what you make
30-39_media        what you keep
```

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
- `31_text` holds text/books and Zotero linked attachments; its Calibre library path
  currently points at `31_text/calibre`, which is not present in the local tree —
  see [`backlog.md`](backlog.md)
- `35_video-games` keeps game repos in `games-library/` and `steam/`

## ｉｎｄｅｘ　ｆｉｌｅｓ

`00_index.md` lives at `~/strata/`. update [`strata.md`](strata.md) first when the tree
changes, then refresh the index. other `00_index.*` files are optional per category.
