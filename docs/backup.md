# ｂａｃｋｕｐ

essential machine-local data → `~/strata/10-19_system/14_backups/`.

the dotfiles repo holds **configuration** (reproducible from GitHub). this covers the
**state and credentials** that live only on this machine and would be lost on a reinstall.

## essentials (`~/bin/backup`)

run anytime — idempotent, one directory per item, latest-wins:

| backup → | source | notes |
|----------|--------|-------|
| `chezmoi/chezmoi.toml` | `~/.config/chezmoi/chezmoi.toml` | nicotine `passw`, aMule `kadUdpKey` — this machine's secret data values |
| `ssh/` | `~/.ssh/` | `id_ed25519` (600 preserved) + pub + `known_hosts` — needed to push this repo (`git@github.com:`) |
| `beets/` | `~/.config/beets/` | `library.db` + config + state (music metadata index) |
| `firefox-profile/` | `~/.mozilla/firefox/*.default-release/` | `logins.json` (saved passwords) + `places.sqlite` (bookmarks/history) |
| `fstab/fstab` | `/etc/fstab` | btrfs subvols + `/mnt/phaedra` `/mnt/valus` boot mounts |

non-secret duplicates living in this repo: `docs/fstab.fedora`.

never committed to the repo: ssh keys, beets db, `chezmoi.toml`, firefox data.

## restore

after a fresh install, copy these back before `chezmoi apply`:
- `chezmoi/chezmoi.toml` → `~/.config/chezmoi/chezmoi.toml` (restores nicotine/amule secret data)
- `ssh/` → `~/.ssh/` (chmod 600 the private key)
- `firefox-profile/{logins.json,places.sqlite}` → your new firefox profile dir
- `beets/` → `~/.config/beets/`
- `fstab/fstab` → `/etc/fstab` (or restore from `docs/fstab.fedora`, then `mount -a`)

## broader policy

service exports (able to generate on demand): see `../14_backups/backup-policy.md`.
strata itself (media, obsidian, kdbx vault, self-hosted) is backed up out-of-band.
explicitly **not** backed up (session/reset-able): chromium profile, dconf/GNOME settings,
manicode/opencode histories, `~/.gnupg`.