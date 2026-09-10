# cargo (topgrade): limit concurrent rustc builds to fit 7GiB RAM
export CARGO_INSTALL_OPTS="--jobs 1"

# eza
export EZA_ICONS_AUTO=1

# eza colors (single source of truth: dot_bash/eza-colors)
EZA_COLORS="$(<"$DOTFILES/dot_bash/eza-colors")"
export EZA_COLORS