# bashrc.d (fedora default)
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        [ -f "$rc" ] && . "$rc"
    done
    unset rc
fi

# starship
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init bash)"

# pkg-config (fedora layout)
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig

# go (installed via dnf at /usr/local/go) — append only if not present
case ":$PATH:" in *":/usr/local/go/bin:"*) ;; *) PATH="$PATH:/usr/local/go/bin" ;; esac

# opencode — add once, never stack
case ":$PATH:" in *":$HOME/.opencode/bin:"*) ;; *) PATH="$HOME/.opencode/bin:$PATH" ;; esac

# pin ~/.local/bin to the front — drop any earlier copies, then prepend, so
# user scripts win over opencode even in non-login shells (no ~/.profile).
# Idempotent, POSIX-only.
if [ -n "$PATH" ]; then
    pinned=""
    IFS_OLD=$IFS
    IFS=:
    for _d in $PATH; do
        [ -z "$_d" ] && continue
        [ "$_d" = "$HOME/.local/bin" ] && continue
        pinned="${pinned}${pinned:+:}${_d}"
    done
    IFS=$IFS_OLD
    unset _d
    export PATH="$HOME/.local/bin:$pinned"
fi
