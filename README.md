# ｄｏｔｆｉｌｅｓ    <img src="./ensō.jpg" width="128" />

![Banner](./banner.jpg)

system configuration, organized in a [johnny decimal](https://johnnydecimal.com/)-inspired strata layout and managed with [chezmoi](https://www.chezmoi.io/).

## ｄｏｃｓ

| doc | authoritative for |
|-----|-------------------|
| [`structure.md`](docs/structure.md) | chezmoi source map and conventions |
| [`strata.md`](docs/strata.md) | filesystem tree and storage topology |
| [`path-architecture.md`](docs/path-architecture.md) | PATH assembly |
| [`apps.md`](docs/apps.md) | installed/evaluated apps, file managers, tracked configs |
| [`hardware.md`](docs/hardware.md) | machine, disks, mounts |
| [`backup.md`](docs/backup.md) | machine-local state and restore steps |

## ｆｒｅｓｈ　ｉｎｓｔａｌｌ

1. restore `~/.ssh` and `~/.config/chezmoi/chezmoi.toml` from backup (see [`backup.md`](docs/backup.md)). the repo is cloned over ssh and `sourceDir` is read from `chezmoi.toml`, so both must be in place before step 3. <!-- TODO: replace with real plakar steps once the backup method is settled -->

2. install chezmoi:

   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
   ```

3. clone the repo and apply:

   ```bash
   ~/.local/bin/chezmoi init --apply --ssh gary-host-laptop
   ```

`apply` writes the managed files, then runs the `run_*` scripts in alphabetical order by target name: package installs, systemd units, nushell init, storage links, and xdg/theming. `run_before_` and `run_after_` scripts run before or after the file updates. `run_once_` scripts execute a single time, `run_onchange_` scripts re-run only when their contents change, and `run_always_` scripts run on every apply.