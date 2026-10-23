# ｂａｃｋｌｏｇ

deferred fixes and known gaps. this file is not a description of current behavior; it
records work that still needs to be done.

## ｓｔｏｒａｇｅ　／　ｘｄｇ

- [ ] make XDG paths declarative:
  - track `~/.config/user-dirs.dirs` with Documents → local `31_text`,
    Music → `32_audio`, Videos → `34_video`
  - track `~/.config/user-dirs.conf` with `enabled=False` so session
    `xdg-user-dirs-update` does not reset missing paths to `$HOME`
  - remove the generated `user-dirs.dirs` / `xdg-user-dirs-update` block from
    `run_once_setup-xdg.sh.tmpl`
- [ ] make storage repair idempotent:
  - keep `31_text` local; remove its `/mnt/valus/31_text` link from
    `run_once_setup-storage.sh.tmpl`
  - run the storage setup on every apply (or key it to mount state) so a replacement
    phaedra relinks `34_video` and `35_video-games/steam`
  - make `link_storage()` refuse to replace real directories, check `ln` failures,
    and verify the final symlink
- [ ] when replacing phaedra: update its UUID in `/etc/fstab` and
  `docs/fstab.fedora`, mount it, then apply
- [ ] decide the Calibre library path: local `31_text` has `books/`, while
  `dot_config/calibre/global.py.json.tmpl` points at `31_text/calibre`

## ａｐｐｓ

- [ ] template Strata's `default_directory` instead of hardcoding
  `/home/ghost_user/strata` in `dot_config/strata/private_settings.toml`
- [ ] install `/etc/firefox/policies/policies.json` from
  `.chezmoitemplates/firefox-policies.json`
- [ ] apply the four missing ZotMoov keys to the live Zotero profile, then test the
  Zotero Connector save path

## ｂａｃｋｕｐ

- [ ] fix `~/.local/bin/backup`: it looks for
  `~/.mozilla/firefox/*.default-release`, but the pinned profile is
  `~/.mozilla/firefox/profile`, so Firefox cookies/bookmarks are currently skipped
