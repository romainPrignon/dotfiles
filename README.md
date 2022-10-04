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
make configure
make configure-desktop
sudo reboot
make snap
```

# manual

Apply what you need from the `makefile`
- completions
- pip
- ...

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
- install extensions:
    - Emoji Selector by Maestroschan
    - dash to panel by charlesg99
    - gtk title bar by velitasali OR no titlebar when maximized (focal) OR pixelsaver (focal)
    - just perfection by JustPerfection
    - escape overview by rael
    - start overlay in application view by hex_cz or tmk
    - alphabetical app grid by stuartheyhurst
    - sound output device chooser by kgshank
    - lock screen background by sun_wang (optional)
    - User Themes by fmuellner

- reload dconf
    ```bash
    make dconf-load
    ```

- after that, configure desktop settings again
    ```bash
    make configure-desktop
    ```

## GRUB
- sudo nano /etc/default/grub
- GRUB_TIMEOUT_STYLE=menu
- GRUB_TIMEOUT=1
- GRUB_CMDLINE_LINUX_DEFAULT="splash quiet" => GRUB_CMDLINE_LINUX_DEFAULT="text quiet"
- OR
- GRUB_CMDLINE_LINUX_DEFAULT="splash quiet" => GRUB_CMDLINE_LINUX_DEFAULT="nosplash"
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

## fzf
- replace `C-t` with `C-e` in /home/romainprignon/.fzf/shell/key-bindings.bash
- replace `^T` with `^E` in /home/romainprignon/.fzf/shell/key-bindings.zsh

## configure gitmoji
```bash
gitmoji -g
```

## terminal
- add keyboard shortcut to focus terminal
    - go to settings > devices > keyboard
    - add custom shortcut
        - name: terminal
        - command: bash /home/romainprignon/scripts/focus-terminal.sh
        - shortcut: CTRL + T

## alt+tab
- add keyboard shortcut to switch windows instead of applications
    - go to settings > devices > keyboard
    - look for switch
    - bind alt+tab to 'switch windows'

## lock and backgroud screen
- use extension for lock
- do it manually for backgroud in settings