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
    - No Title Bar - Forked by BebopXD
    - TaskBar 2020 by c0ldplasma
    - User Themes by fmuellner
- reload dconf
    ```bash
    make dconf-load
    ```


## vscode
- install extensions
    ```bash
    make vscode
    ```
- reload


## subl
- install package control
- relaunch

## intellij
- install extensions:
    - js-graphql-intellij-plugin
- remove unused extensions (doc/unused-phpstorm-ext.txt)

## TODO manual
- setup tlp
- setup swap (/etc/fstab and /etc/sysctl.conf)
- keyboard: remove caps (/usr/share/X11/xkb/symbols/pc)
- focus terminal
