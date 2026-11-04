# path

PATH is inherited and assembled in layers. Two of those layers are dotfile-owned entry points:

- `environment.d/90-user.conf` — systemd --user baseline, applied before any shell.
- `~/.profile` — bash login, tty, ssh, rescue, and the GDM-sourced GUI pass.

They are not disjoint halves of PATH. Each layer prepends, appends, or dedupes the same inherited value, so the final order depends on which entry points ran and in what order.

## contributors

- **systemd default**: `/usr/local/bin:/usr/bin`.
- **`environment.d/90-user.conf`**: prepends `~/.local/bin`, `~/.cargo/bin`, `~/.opencode/bin`, and `/usr/local/go/bin`. This is the GUI/systemd starting baseline, before login-shell additions. It does not contain `/usr/lib64/ccache`.
- **`~/.profile`**: prepends `~/.opencode/bin`, sources `~/.cargo/env`, appends `/usr/local/go/bin`, then pins `~/.local/bin` to the front and drops empty/duplicate entries.
- **`~/.bash_profile`**: login bash sources `~/.profile`, then `~/.bashrc`.
- **`~/.bashrc`**: non-login interactive bash sources `/etc/bashrc`, then sources `~/.profile` once if `_DOTFILES_PROFILE_SOURCED` is unset, then loads `dot_bash/*`.
- **`/etc/profile.d/ccache.sh`**: sole source of `/usr/lib64/ccache`. It is applied by `/etc/profile` for login shells and by `/etc/bashrc` for interactive non-login shells.
- **`~/.cargo/env`**: rustup-owned; adds `~/.cargo/bin` when `~/.profile` sources it.

## gdm

Fedora GDM does not source `~/.profile` through `/etc/profile`.

```
/etc/gdm/Xsession
  -> /etc/X11/xinit/xinitrc-common
     -> ~/.profile
  -> exec -l $SHELL -c gnome-session
     -> /etc/profile                  # adds /etc/profile.d/ccache.sh
     -> ~/.bash_profile
        -> ~/.profile               # pins ~/.local/bin ahead of ccache
        -> ~/.bashrc
```

So in a GUI session `~/.profile` runs twice: once from xinitrc-common and once from the login shell. The second pass reorders `~/.local/bin` ahead of ccache but does not duplicate entries.

## observed orders

GUI/current, verified from `gnome-shell`, `ghostty`, `zellij`, `nu`, Firefox, and `systemctl --user show-environment`:

```
~/.local/bin:/usr/lib64/ccache:~/.cargo/bin:~/.opencode/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin
```

Clean bash login; expected to match tty/ssh (actual tty/ssh was not opened during this audit):

```
~/.local/bin:~/.cargo/bin:~/.opencode/bin:/usr/lib64/ccache:/usr/local/bin:/usr/bin:/usr/local/go/bin
```

Clean interactive bash: same as clean login.

Clean non-interactive bash:

```
/usr/local/bin:/usr/bin
```

Non-interactive shells do not read profile files; they normally inherit the caller's PATH.

systemd user service started before the login-shell PATH import, verified from `move-media.service`:

```
~/.local/bin:~/.cargo/bin:~/.opencode/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin
```

`systemctl --user show-environment` after login matches the GUI final PATH. It is not a pre-login baseline; use a user service environment for that.

No duplicates, empty entries, or missing entries were found in these captures. Sourcing `~/.profile` twice is idempotent, and a polluted ancestor PATH converges on the next login.

## nushell

On Nushell 0.99.1, `env.nu` runs before the inherited environment strings are converted to Nushell values, so PATH is a colon-separated string there. `env.nu` splits it for list operations, dedupes, and joins it back to a string. `config.nu` does not modify PATH. After both startup files, Nushell converts PATH to `list<string>` for the REPL, then converts it back to a colon-separated string when invoking external commands.

`env.nu` never adds entries. The string/list guard keeps it safe if PATH is already a list, either from a changed startup context or a newer Nushell version. The live `nu` PATH matches the GUI seven entries with no duplicates.

## maintenance

Add new paths to `~/.profile` and mirror them in `environment.d/90-user.conf`. Do not add PATH entries in nushell or `.bashrc`.
