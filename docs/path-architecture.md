# ｐａｔｈ　ａｒｃｈｉｔｅｃｔｕｒｅ

`PATH` is assembled at two converging roots. both are add-once, so entries never duplicate across sessions.

**`environment.d/90-user.conf`** — applied by `systemd --user` at boot. this is the root for the GUI/session tree: GNOME → ghostty → zellij → nushell. processes that have no bash ancestor inherit PATH from here.

**`~/.profile`** — the bash/login/tty/rescue root. fedora's GDM also sources it at session start, so GUI processes see the same PATH as login shells.

canonical order:
```
~/.local/bin → ~/.cargo/bin → ~/.opencode/bin → /usr/lib64/ccache → /usr/local/bin → /usr/bin → /usr/local/go/bin
```

`~/.bashrc` sources `~/.profile` once for non-login interactive bash, then `fedora-specific.bash` for fedora-only additions.

`nushell/env.nu` only normalizes the inherited PATH (dedup, string→list conversion) — it never adds entries. new paths always go into one of the two roots above.
