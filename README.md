# Usage

## dependencies
 - git

## fast path
```bash
make install
sudo reboot
make bootstrap
sudo reboot
```

## long path
```bash
git clone https://github.com/romainprignon/dotfiles.git
cd dotfiles
sudo bash ./install.sh 2>&1 | tee ~/install.log
sudo reboot
./bootstrap.sh
sudo reboot
```

# Reminder

**vscode**
subl $(locate workbench.main.css)
append this file => https://gist.github.com/romainPrignon/cfe7087451354456ed0ddd08e02274a4

**gnome-shell**
BingWallpaper@ineffable-gmail.com  hide-dash@xenatt.github.com       pixel-saver@deadalnix.me
bottompanel@tmoer93                hide-workspace@xenatt.github.com  TaskBar@zpydr

## TODO manual
- sublime: install package control
- vscode: copy workbench
- vscode: install plugins
- phpstorm: install plugins
- phpstorm: remove unused plugins
- gnome: install extensions
- file: bookmark (app, workspace,...)
- keyboard: remove caps (/usr/share/X11/xkb/symbols/pc)
- chrome: app shortcuts (cloud9, di.fm, docker, evernote, gantter, gmail peaks, calendar, drive, hub, lucidchart, mockup, pixlr, scribens, slack, spotify, stackedit)
