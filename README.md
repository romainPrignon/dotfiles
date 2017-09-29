# Usage

## dependencies
 - git

## Linux
```bash
git clone https://github.com/romainprignon/dotfiles.git
cd dotfiles
sudo bash ./install.sh 2>&1 | tee ~/install.log
sudo reboot
./bootstrap.sh
sudo reboot
```

## Windows
```
bootstrap.bat
```

# manual install
```bash
apt install -y google-drive-ocamlfuse
apt install -y ttf-mscorefonts-installer
apt install --reinstall ttf-mscorefonts-installer
```

# Reminder

**Dump conf**
```bash
dconf dump /org/gnome/nautilus/ > nautilus.dconf
dconf dump /org/gnome/power-manager/ > power-manager.dconf
dconf dump /org/gnome/settings-daemon/ > settings-daemon.dconf
dconf dump /org/gnome/shell/ > shell.dconf
dconf dump /org/gnome/terminal/ > terminal.dconf
dconf dump /org/gnome/desktop/ > desktop.dconf
```

**Load conf**
```bash
dconf load /org/gnome/nautilus/ < nautilus.dconf
dconf load /org/gnome/power-manager/ < power-manager.dconf
dconf load /org/gnome/settings-daemon/ < settings-daemon.dconf
dconf load /org/gnome/shell/ < shell.dconf
dconf load /org/gnome/terminal/ < terminal.dconf
dconf load /org/gnome/desktop/ < desktop.dconf
```

**Dump atom settings**
```bash
apm list --installed --bare > atom-package.txt
```

**Load atom settings**
```bash
apm install --packages-file atom-package.txt
```

**vscode**
subl $(locate workbench.main.css)
append this file => https://gist.github.com/jakewtaylor/e92acd697409e53a73ebf8e0145d4c28

subl $(locate workbench.main.js)
append this file => https://gist.github.com/WadeShuler/1637073371ad126779076344c34278f3

## TODO
- [ ] !
