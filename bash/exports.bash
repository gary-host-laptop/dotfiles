# path
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# pkg-config
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig

# eza
export EZA_ICONS_AUTO=1
