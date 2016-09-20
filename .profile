# include env vars
if [ -f "$HOME/.exports" ]; then
    . "$HOME/.exports"
fi

if [ -f "$HOME/.exports_linux" ]; then
    . "$HOME/.exports_linux"
fi

if [ -f "$HOME/.exports_windows" ]; then
    . "$HOME/.exports_windows"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi
