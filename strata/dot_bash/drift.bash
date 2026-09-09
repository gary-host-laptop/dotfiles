# drift — idle terminal screensaver (shell integration)
if command -v drift &>/dev/null; then
    export DRIFT_TIMEOUT=120
    eval "$(drift shell-init bash)"
fi