# path
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export PATH="/opt/ninix-kagari/bin:$PATH"

# pkg-config
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig
