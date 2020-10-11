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


## Ntp
- sudo timedatectl set-timezone My/Timezone


## Hostname
- sudo hostnamectl set-hostname MY_HOSTNAME
- micro /etc/hosts


## Keyboard (if qwerty)
- in /usr/share/X11/xkb/symbols/pc
```
key <CAPS> {    [ Caps_Lock     ]   };
```
- remove caps lock
```
key <CAPS> {};
```


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


## webapp
- go to chrome://apps/
- install shortcuts:
    - devdocs


## intellij
- install extensions:
    - js-graphql-intellij-plugin
- remove unused extensions (doc/unused-phpstorm-ext.txt)


## terminal
- add keyboard shortcut to focus terminal
    - go to settings > devices > keyboard
    - add custom shortcut
        - name: terminal
        - command: bash /home/romainprignon/scripts/focus-terminal.sh
        - shortcut: CTRL + T
