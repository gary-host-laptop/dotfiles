# ｓｔｒａｔａ

personal filesystem organized with a [johnny decimal](https://johnnydecimal.com/)-inspired
scheme: every folder gets a two-digit id, ids are grouped into ten-wide categories
(`10–19`, `20–29`, `30–39`), and each item has a unique, predictable location.

`docs/strata.md` is the canonical description — the on-disk `~/strata/00_index.*` files
mirror this tree (drive layout: `docs/hardware.md`; backups: `docs/backup.md`).

## ｃａｔｅｇｏｒｉｅｓ

```
10-19_system       the machine you live in
20-29_praxis       what you make
30-39_media        what you keep
```

## ｔｒｅｅ

```
~/strata/
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
    ├── 31_text
    ├── 32_audio
    ├── 33_images
    ├── 34_video
    └── 35_video-games
```

media keeps the big data off the system drive — `31–33` are symlinks into
`/mnt/valus`, `34–35` into `/mnt/phaedra` (created by `run_once_setup-storage.sh`):

| category | source location |
|----------|-----------------|
| 31_text, 32_audio, 33_images | → `/mnt/valus/{31_text,32_audio,33_images}` |
| 34_video, 35_video-games | → `/mnt/phaedra/{34_video,35_video-games}` |

## ｃｏｎｖｅｎｔｉｏｎｓ

- ids are two digits; groups own the whole ten range (`11–17` inside `10–19`)
- a category may hold a `00_index.*` describing its contents — the top-level index
  is `~/strata/00_index.{md,txt}` (regenerated from this doc; `.png` is the visual map)
- `30-39` resizeable media mounts mean `31_text` doubles as the calibre library root
  and `35_video-games` holds game repos (`games-library/`, `steam/`)

## ｉｎｄｅｘ　ｆｉｌｅｓ

`00_index.md` (rendered) and `00_index.txt` (plain) live at `~/strata/`. they track the
tree above; if the tree changes, update `docs/strata.md` first, then refresh the indexes.