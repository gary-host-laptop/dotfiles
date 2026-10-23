# ｐａｔｈ　ａｒｃｈｉｔｅｃｔｕｒｅ

`PATH` is assembled at two converging roots. both are add-once, so entries never duplicate across sessions.

**`environment.d/90-user.conf`** — applied by `systemd --user` at boot. this is the root for the GUI/session tree: GNOME → ghostty → zellij → nushell. processes that have no bash ancestor inherit PATH from here.

**`~/.profile`** — the bash/login/tty/rescue root. fedora's GDM also sources it at session start, so GUI processes see the same PATH as login shells.

current observed login order:
```
~/.local/bin → /usr/lib64/ccache → ~/.cargo/bin → ~/.opencode/bin → /usr/local/go/bin → /usr/local/bin → /usr/bin
```

verify with nushell (the daily shell — `$env.PATH` is already a list by the time
`config.nu` finishes):

```nu
$env.PATH | enumerate          # index + entry, in assembly order
$env.PATH | uniq --repeated    # duplicates
```

in a bash login shell, tty, or rescue session:

```bash
printf '%s\n' "$PATH" | tr ':' '\n' | nl -ba
printf '%s\n' "$PATH" | tr ':' '\n' | sort | uniq -d
```

empty output from the duplicate checks means no duplicates.

`~/.bashrc` sources `~/.profile` once for non-login interactive bash, then loads
`dot_bash/{exports,aliases,drift}.bash`.

`nushell/env.nu` only normalizes the inherited PATH (dedup, string→list conversion) — it never adds entries. new paths always go into one of the two roots above.
