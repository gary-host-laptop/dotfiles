# ｄｏｔｆｉｌｅｓ

![Banner](./banner.jpg)

personal system configuration organized within a [johnny decimal](https://johnnydecimal.com/) inspired strata file system managed by [chezmoi](https://www.chezmoi.io/).

## ｄｏｃｓ

| doc | authoritative for |
|-----|-------------------|
| [`structure.md`](docs/structure.md) | chezmoi source map and conventions |
| [`strata.md`](docs/strata.md) | filesystem tree and storage topology |
| [`path-architecture.md`](docs/path-architecture.md) | PATH assembly |
| [`apps.md`](docs/apps.md) | installed/evaluated apps, file managers, tracked configs |
| [`hardware.md`](docs/hardware.md) | machine, disks, mounts |
| [`backup.md`](docs/backup.md) | machine-local state and restore steps |
| [issues](https://github.com/gary-host-laptop/dotfiles/issues) | deferred fixes and known gaps |

---

## ｆｒｅｓｈ　ｉｎｓｔａｌｌ

before running, create `~/.config/chezmoi/chezmoi.toml` (see [multi-machine](#ｍｕｌｔｉ‑ｍａｃｈｉｎｅ)).

```bash
# install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"

# clone repo and apply everything
chezmoi init --source ~/strata/10-19_system/13_system-config/dotfiles --apply gary-host-laptop
```

chezmoi applies managed files and runs the `run_onchange_*` / `run_once_*` scripts as
part of the apply: package installs, systemd units, nushell init, storage links, and
XDG/theming. scripts run in source/name order; re-run `chezmoi apply` after changing
machine-local data or mounting storage.

---

## ｍｕｌｔｉ‑ｍａｃｈｉｎｅ

on each machine, create `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
machine = "fedora"   # or "nixos"

# per-machine secrets — never stored in the repo
# omitting these degrades gracefully (aMule regenerates its key, nicotine+ uses blank password)
[data.amule]
kadUdpKey = "0"
[data.nicotine]
password = "..."
```

`.tmpl` files use `{{ if eq (.machine | default "fedora") "..." }}` — the `| default "fedora"` fallback means the repo applies even without a `chezmoi.toml`.