# nushell environment (mirrors bash/exports.bash + profile.symlink for nu sessions)
# keeps interactive env identical across shells; scripts stay shell-agnostic.

$env.PATH = (
    $env.PATH
    | prepend [$"($env.HOME)/.local/bin" $"($env.HOME)/bin" $"($env.HOME)/.cargo/bin"]
    | append ["/usr/local/go/bin"]
    | reduce --fold [] {|entry, acc|
        if ($entry in $acc) { $acc } else { $acc ++ [$entry] }
      }
    | str join ":"
)

$env.PKG_CONFIG_PATH = "/usr/lib64/pkgconfig"

$env.CARGO_INSTALL_OPTS = "--jobs 1"

$env.EZA_ICONS_AUTO = "1"

# eza colors (official folke tokyonight_night theme values — keep in sync with bash/exports.bash)
$env.EZA_COLORS = "di=38;2;122;162;247;1:ln=38;2;42;195;222:ex=38;2;158;206;106:fi=38;2;192;202;245:*.md=38;2;187;154;247:*.toml=38;2;187;154;247:*.sh=38;2;187;154;247:*.rs=38;2;187;154;247:*.go=38;2;187;154;247:*.py=38;2;187;154;247:*.js=38;2;187;154;247:*.ts=38;2;187;154;247:*.json=38;2;187;154;247:*.yml=38;2;187;154;247:*.yaml=38;2;187;154;247:*.jpg=38;2;137;221;255:*.png=38;2;137;221;255:*.gif=38;2;137;221;255:*.mp4=38;2;180;249;248:*.mp3=38;2;115;218;202:*.zip=38;2;255;158;100:*.tar=38;2;255;158;100:*.gz=38;2;255;158;100:uu=38;2;122;162;247:gu=38;2;122;162;247:un=38;2;169;177;214:gn=38;2;169;177;214"

# starship — point at the repo's shared prompt config (init happens in config.nu)
$env.STARSHIP_CONFIG = $"($env.HOME)/strata/10-19_system/13_system-config/dotfiles/config/starship.toml"
