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
append this file => https://gist.github.com/romainPrignon/cfe7087451354456ed0ddd08e02274a4

subl $(locate workbench.main.js)
append this file => https://gist.github.com/romainPrignon/e43da544a3deac595582b10aaa15e505

**gnome-shell**
BingWallpaper@ineffable-gmail.com  hide-dash@xenatt.github.com       pixel-saver@deadalnix.me
bottompanel@tmoer93                hide-workspace@xenatt.github.com  TaskBar@zpydr

## TODO manual
- sublime: install package control
- vscode: copy workbench
- atom: install plugins
- code: install plugins
- jetbrains: install jetbain-toolbox
- phpstorm: install plugins
- phpstorm: remove unused plugins
- gnome: install extensions
- file: bookmark (app, workspace)
- chrome: app shortcuts (cloud9, di.fm, docker, evernote, gantter, gmail peaks, calendar, drive, hub, lucidchart, mockup, pixlr, scribens, slack, spotify, stackedit)
