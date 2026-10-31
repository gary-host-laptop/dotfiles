# <img src="./ensō.png" width="64" /> ｄｏｔｆｉｌｅｓ

![Banner](./banner.jpg)

system configuration, organized in a [johnny decimal](https://johnnydecimal.com/)-inspired strata layout and managed with [chezmoi](https://www.chezmoi.io/).

## ｄｏｃｓ

| doc | authoritative for |
|-----|-------------------|
| [`structure.md`](docs/structure.md) | chezmoi source map and conventions |
| [`strata.md`](docs/strata.md) | filesystem tree and storage topology |
| [`path.md`](docs/path.md) | PATH assembly |
| [`apps.md`](docs/apps.md) | installed/evaluated apps, file managers, tracked configs |
| [`hardware.md`](docs/hardware.md) | machine, disks, mounts |
| [`backup.md`](docs/backup.md) | machine-local state and restore steps |

## ｆｒｅｓｈ　ｉｎｓｔａｌｌ

1. install plakar:

   ```bash
   cat <<'EOF' | sudo tee /etc/yum.repos.d/plakar.repo
   [plakar]
   name=Plakar Repository
   baseurl=https://plakar.io/dist/repos/rpm/$basearch/
   enabled=1
   gpgcheck=0
   repo_gpgcheck=1
   gpgkey=https://plakar.io/dist/keys/plakar-packages.gpg
   EOF
   sudo dnf install plakar
   plakar version
   ```

2. restore the bootstrap secrets from the Plakar store. the store must already be
   at `~/strata/10-19_system/14_backups/plakar-store/` or copied there from
   off-device media. recover the passphrase from KeePassXC or paper, list the
   snapshots, and restore the newest one:

   ```bash
   sudo install -d -m700 -o root -g root /etc/plakar
   sudo install -m600 -o root -g root /path/to/recovered-passphrase /etc/plakar/passphrase
   sudo plakar -keyfile /etc/plakar/passphrase \
     at ~/strata/10-19_system/14_backups/plakar-store ls
   snapshot_id=PASTE_ID_FROM_LS
   sudo plakar -keyfile /etc/plakar/passphrase \
     at ~/strata/10-19_system/14_backups/plakar-store \
     restore -to /tmp/plakar-restore "$snapshot_id"
   sudo chown -R ghost_user:ghost_user /tmp/plakar-restore
   install -d -m700 ~/.ssh
   cp -a /tmp/plakar-restore/ssh/. ~/.ssh/
   install -Dm600 /tmp/plakar-restore/chezmoi/chezmoi.toml ~/.config/chezmoi/chezmoi.toml
   chmod 600 ~/.ssh/id_ed25519
   rm -rf /tmp/plakar-restore
   ```

   `~/.ssh` and `~/.config/chezmoi/chezmoi.toml` must exist before step 4: the
   repo is cloned over ssh and `sourceDir` is read from `chezmoi.toml`.

3. install chezmoi:

   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
   ```

4. clone the repo and apply:

   ```bash
   ~/.local/bin/chezmoi init --apply --ssh gary-host-laptop
   ```

`apply` writes the managed files, then runs the `run_*` scripts in alphabetical order by target name: package installs, systemd units, nushell init, storage links, and xdg/theming. `run_before_` and `run_after_` scripts run before or after the file updates. `run_once_` scripts execute a single time, `run_onchange_` scripts re-run only when their contents change, and `run_always_` scripts run on every apply.