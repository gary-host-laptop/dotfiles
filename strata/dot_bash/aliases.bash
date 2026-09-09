alias ls='eza'
alias ll='eza -lah'
alias lt='eza --tree'
alias la='eza -a'
alias lg='eza -l --git'
alias tg='topgrade'

# yank (dnf ships the binary as yank-cli) — copy the picked field via wl-copy
# (Wayland clipboard, RAM-only); passing your own `--` overrides the copy command
if command -v yank-cli >/dev/null 2>&1; then
    yank() {
        case " $* " in
            *" -- "*) yank-cli "$@" ;;
            *)        yank-cli "$@" -- wl-copy ;;
        esac
    }
fi
