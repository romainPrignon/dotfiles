## Installation

**Usage**
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

**Load gconf**
```bash
gconftool-2 --load=./exported-settings/gconf-gnome-terminal.xml
```
