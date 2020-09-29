# Usage

> git clone https://github.com/romainprignon/dotfiles
> git clone https://frama.likn/rp-dot

## dependencies
 - git
 - make

## auto
```bash
make install
make desktop
sudo reboot
make configure
sudo reboot
```

# manual

## dropbox
- launch and configure

## gnome-shell
- install extensions:
    - AlternateTab by fmuellner
    - BottomPanel by abstract
    - Hide Dash X by edh
    - Hide Workspace Thumbnails by edh
    - Pixel Saver by nMqMgEF
    - User Themes by fmuellner
    
TODO : make it work ! on vm ! reload snapshot and retry till it work
icon
fav sublime
prompt not bright

- reload dconf
```bash
make dconf-load
```

**vscode**
subl $(locate workbench.main.css)
append this file => https://gist.github.com/romainPrignon/cfe7087451354456ed0ddd08e02274a4

**intellij**
js-graphql-intellij-plugin

## TODO manual
- setup tlp
- setup swap (/etc/fstab and /etc/sysctl.conf)
- sublime: install package control
- vscode: copy workbench
- vscode: install plugins
- phpstorm: install plugins
- phpstorm: remove unused plugins
<!-- - file: bookmark (app, workspace,...) -->
- keyboard: remove caps (/usr/share/X11/xkb/symbols/pc)
