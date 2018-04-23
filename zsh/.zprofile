# include env vars
if [ -f "$HOME/.exports" ]; then
    source "$HOME/.exports"
fi

if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi

# enable google-drive
if [ -x "$(command -v google-drive-ocamlfuse)" ]; then
    google-drive-ocamlfuse -label peaks /home/$USER/drive-peaks
fi
