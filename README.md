## Installation

**Usage**
 - install machine first: curl -sSL https://git.io/v5cB8 | sudo bash
 - copy bootstrap.sh.dist or bootstrap.bat.dist into bootstrap.sh and modify [home-dir-absolute-path] and [dotfile-dir-absolute-path]
 - Change name and email in .gitonfig

On linux:
```bash
git clone https://github.com/romainprignon/dotfiles.git
cd dotfiles
./bootstrap.sh
```
On windows :
```
bootstrap.bat
```

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

## TODO
- [ ] clean desktp settings (compiz, dconf, gconf,...)
