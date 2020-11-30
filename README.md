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


## Swap
- Create swap file if not already done
```bash
make swap size=8G
```


## Ntp
- sudo timedatectl set-timezone My/Timezone


## Hostname
- sudo hostnamectl set-hostname MY_HOSTNAME
- micro /etc/hosts
- micro /etc/hostname


## Keyboard (if qwerty)
- in /usr/share/X11/xkb/symbols/pc
```
key <CAPS> {    [ Caps_Lock     ]   };
```
- remove caps lock
```
key <CAPS> {};
```


## insync
- launch and configure


## gnome-shell
- configure desktop settings
    ```bash
    make configure-desktop
    ```
- install extensions:
    - AlternateTab by fmuellner
    - AppIndicator and KStatusNotifierItem Support by 3v1n0
    - BottomPanel by abstract
    - Emoji Selector by Maestroschan
    - Hide Dash X by edh
    - Hide Workspace Thumbnails by edh
    - No Title Bar by franglais125
    - Pixel Saver by nMqMgEF
    - TaskBar 2020 by c0ldplasma
    - User Themes by fmuellner
    - Window Search Provider by klorenz
- reload dconf
    ```bash
    make dconf-load
    ```


## GRUB
- sudo nano /etc/default/grub
- GRUB_CMDLINE_LINUX_DEFAULT="splash quiet" => GRUB_CMDLINE_LINUX_DEFAULT="text quiet"
- sudo update-grub


## WIFI
- sudo nano /etc/netplan/01-netcfg.yaml
- use `NetworkManager` as renderer


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


## git stash
- remove line `120` from `~/.bash-git-prompt/gitstatus.sh`


## configure gitmoji
```bash
gitmoji -g
```
