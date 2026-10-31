# ｂａｃｋｕｐ

essential machine-local data → `~/strata/10-19_system/14_backups/data/`.

the dotfiles repo holds **configuration** (reproducible from GitHub). this covers the
**state and credentials** that live only on this machine and would be lost on a reinstall.

Plakar keeps versioned snapshots of `data/` in
`~/strata/10-19_system/14_backups/plakar-store/`. the store is encrypted and is a
sibling of `data/`, so it never snapshots itself.

## essentials (`~/.local/bin/strata-backup`)

run through systemd so the root-owned passphrase is available without a prompt:

```bash
sudo systemctl start strata-backup.service
sudo journalctl -u strata-backup.service -b
```

the system unit runs `/usr/local/bin/strata-backup`, installed from the dotfile.
running `~/.local/bin/strata-backup` directly also works, but Plakar will prompt for the
store passphrase.

systemd cannot execute a user-managed binary under SELinux, so the install script
keeps the runner in `/usr/local/bin`. Plakar may come from `/usr/bin` (dnf) or
`/usr/local/bin` (copied by the install script); the backup script prefers the
system copy and only falls back to `~/.local/bin/plakar` for manual runs.

the script refreshes these items, then snapshots all of `data/`:

| backup → | source | notes |
|----------|--------|-------|
| `data/chezmoi/chezmoi.toml` | `~/.config/chezmoi/chezmoi.toml` | nicotine `passw`, aMule `kadUdpKey` — this machine's secret data values |
| `data/ssh/` | `~/.ssh/` | `id_ed25519` (600 preserved) + pub + `known_hosts` — needed to push this repo (`git@github.com:`) |
| `data/beets/` | `~/.config/beets/` | `library.db` + config + state (music metadata index) |
| `data/firefox-profile/` | `~/.mozilla/firefox/ghost-profile/` | `cookies.sqlite` (saved log-in sessions) + `places.sqlite` (bookmarks/history), copied from a DB+WAL snapshot so live Firefox locks do not block the backup |
| `data/fstab/fstab` | `/etc/fstab` | btrfs subvols + `/mnt/phaedra` `/mnt/valus` boot mounts |

other directories in `data/` are manual service exports; they are snapshotted but
not refreshed by the script.

non-secret duplicates living in this repo: `docs/fstab.fedora`.

never committed to the repo: ssh keys, beets db, `chezmoi.toml`, firefox data.

## plakar snapshots

| item | value |
|------|-------|
| store | `~/strata/10-19_system/14_backups/plakar-store/` |
| source | `~/strata/10-19_system/14_backups/data/` |
| passphrase | `/etc/plakar/passphrase` (`root:root`, `0600`) |
| service | `strata-backup.service` (system unit) |
| timer | `strata-backup.timer` — daily at 08:00, catches missed runs |
| retention | daily prune: 7 daily, 4 weekly, 12 monthly |
| logs | `sudo journalctl -u strata-backup.service` |

inspect the store as root:

```bash
sudo plakar \
  -keyfile /etc/plakar/passphrase \
  at /home/ghost_user/strata/10-19_system/14_backups/plakar-store ls
```

verify integrity:

```bash
sudo plakar \
  -keyfile /etc/plakar/passphrase \
  at /home/ghost_user/strata/10-19_system/14_backups/plakar-store check
```

### retention

after each successful snapshot, `strata-backup` prunes the store to keep roughly
20 snapshots:

| window | keep |
|--------|------|
| last 7 days | 1 per day |
| last 4 weeks | 1 per week |
| last 12 months | 1 per month |

the windows overlap: recent days are kept individually, older weeks and months
are thinned out. `plakar prune` is a dry run unless `-apply` is given. preview it
with:

```bash
sudo plakar \
  -keyfile /etc/plakar/passphrase \
  at /home/ghost_user/strata/10-19_system/14_backups/plakar-store \
  prune -tag essentials \
  -days 7 -per-day 1 \
  -weeks 4 -per-week 1 \
  -months 12 -per-month 1
```

the service adds `-apply`, then runs `plakar maintenance` to reclaim space.
maintenance may lag because deleted packs are kept for a grace period.

### passphrase recovery

the store passphrase is also kept in KeePassXC and on paper/offline media. the
KDBX file alone is not sufficient: if the store is the only copy of the KDBX and
the passphrase is lost, the store cannot be opened. keep the recovery copy outside
the Plakar store.

if `/etc/plakar/passphrase` is lost but the recovery copy exists, recreate it:

```bash
sudo install -d -m700 -o root -g root /etc/plakar
sudo install -m600 -o root -g root /path/to/recovered-passphrase /etc/plakar/passphrase
```

if the passphrase is lost, the encrypted store cannot be recovered.

if the passphrase is exposed, Plakar cannot rekey in place: create a new store,
back up into it, swap the store and key, then remove the old store.

## restore

### fresh install

restore only the bootstrap files needed to clone this repo: `~/.ssh/` and
`~/.config/chezmoi/chezmoi.toml`. the store must already be at the path below or
copied there from off-device media; recover the passphrase from KeePassXC or
paper. `ls` prints the snapshot IDs; use the newest one in `restore`:

```bash
sudo install -d -m700 -o root -g root /etc/plakar
sudo install -m600 -o root -g root /path/to/recovered-passphrase /etc/plakar/passphrase
sudo plakar \
  -keyfile /etc/plakar/passphrase \
  at /home/ghost_user/strata/10-19_system/14_backups/plakar-store ls
snapshot_id=PASTE_ID_FROM_LS
sudo plakar \
  -keyfile /etc/plakar/passphrase \
  at /home/ghost_user/strata/10-19_system/14_backups/plakar-store \
  restore -to /tmp/plakar-restore "$snapshot_id"
sudo chown -R ghost_user:ghost_user /tmp/plakar-restore
install -d -m700 ~/.ssh
cp -a /tmp/plakar-restore/ssh/. ~/.ssh/
install -Dm600 /tmp/plakar-restore/chezmoi/chezmoi.toml ~/.config/chezmoi/chezmoi.toml
chmod 600 ~/.ssh/id_ed25519
rm -rf /tmp/plakar-restore
```

### normal restore

restore a snapshot to a temporary directory, then copy the files you need:

```bash
sudo mkdir -p /tmp/plakar-restore
sudo plakar \
  -keyfile /etc/plakar/passphrase \
  at /home/ghost_user/strata/10-19_system/14_backups/plakar-store ls
snapshot_id=PASTE_ID_FROM_LS
sudo plakar \
  -keyfile /etc/plakar/passphrase \
  at /home/ghost_user/strata/10-19_system/14_backups/plakar-store \
  restore -to /tmp/plakar-restore "$snapshot_id"
sudo chown -R ghost_user:ghost_user /tmp/plakar-restore
```

`/tmp` contains the restored secrets. delete it when finished:

```bash
rm -rf /tmp/plakar-restore
```

after restoring, copy these back before `chezmoi apply`:
- `chezmoi/chezmoi.toml` → `~/.config/chezmoi/chezmoi.toml` (restores nicotine/amule secret data)
- `ssh/` → `~/.ssh/` (chmod 600 the private key)
- `firefox-profile/{cookies.sqlite,places.sqlite}` → `~/.mozilla/firefox/ghost-profile/`
- `beets/` → `~/.config/beets/`
- `fstab/fstab` → `/etc/fstab` (or restore from `docs/fstab.fedora`, then `mount -a`)

## broader policy

service exports and the broader policy: see
`~/strata/10-19_system/14_backups/backup-policy.md`.

the local Plakar store is on the same LUKS disk. it protects against accidental
deletion and gives version history, but it is **not** disaster recovery until it
is copied off-device.

strata itself (media, obsidian, kdbx vault, self-hosted) is backed up out-of-band.
explicitly **not** backed up (session/reset-able): chromium profile, dconf/GNOME settings,
manicode/opencode histories, `~/.gnupg`.
