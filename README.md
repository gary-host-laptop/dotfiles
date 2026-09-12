# ｄｏｔｆｉｌｅｓ

personal system configuration for fedora linux, managed by [chezmoi](https://www.chezmoi.io/) and organized within a [johnny decimal](https://johnnydecimal.com/) inspired strata file system. templates support fedora (current) and nixos (planned).

→ [structure](docs/structure.md) · [strata](docs/strata.md) · [path architecture](docs/path-architecture.md) · [apps](docs/apps.md) · [hardware](docs/hardware.md)

---

## ｆｒｅｓｈ　ｉｎｓｔａｌｌ

before running, create `~/.config/chezmoi/chezmoi.toml` (see [multi-machine](#ｍｕｌｔｉ‑ｍａｃｈｉｎｅ)).

```bash
# install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"

# clone repo and apply everything
chezmoi init --source ~/strata/10-19_system/13_system-config/dotfiles --apply gary-host-laptop
```

chezmoi will install packages, set up xdg dirs, create storage symlinks, generate nushell init, and enable systemd units — in that order.

---

## ｕｓｉｎｇ　ｃｈｅｚｍｏｉ

```bash
chezmoi apply            # apply pending changes
chezmoi edit <file>      # edit a managed file (opens in $EDITOR)
chezmoi cd               # cd to the source directory
chezmoi diff             # see what would change
chezmoi status           # current state vs managed
chezmoi forget <file>    # stop managing a file
```

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

---

## ｓｔｒａｔａ

this repo lives at `~/strata/10-19_system/13_system-config/dotfiles`. full strata layout and drive mapping: [`docs/strata.md`](docs/strata.md).
