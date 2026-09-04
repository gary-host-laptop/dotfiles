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

export PATH=$PATH:/usr/local/go/bin

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
