# nixos: most shell init is meant to be managed by home.nix — this stub exists
# so private_dot_bashrc.tmpl can source *-specific.bash on every machine.
# Keep starship/zoxide in sync with the nushell config if you wire them here.

# bashrc.d (keep parity with fedora)
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