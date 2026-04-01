# Usage

> git clone https://github.com/romainprignon/dotfiles
> git clone https://frama.link/rp-dot

## Dependencies
 - git
 - make

## Installation (Debian 13+)

### Automated Setup
```bash
make install
make desktop
make configure
make configure-desktop
sudo reboot
make snap
```

### Runtime Installation (via mise)
Runtimes are managed via [mise](https://mise.jdx.dev/) and can be installed individually:

```bash
make install-node         # Install Node.js (LTS + latest)
make install-python       # Install Python 3.12 and 3.8
make install-go           # Install Go
make install-rust         # Install Rust
make install-deno         # Install Deno
make install-java         # Install Java OpenJDK 17
make install-poetry       # Install Poetry
make install-php          # Install PHP 8.1 + Composer
make install-terraform    # Install Terraform
make install-packer       # Install Packer
make install-gh           # Install GitHub CLI
make install-kubectl      # Install kubectl
make install-broot        # Install broot

# Or install all runtimes at once
make install-all-runtimes
```

## Manual Configuration

## Manual Configuration

Apply what you need from the `makefile`:
- completions (bash and zsh)
- pip
- npm
- composer
- ...

## Git SSH Signing

Configure SSH signing for Git commits:

1. Generate an SSH key (if you don't have one):
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

2. Add your SSH public key to GitHub:
   - Go to GitHub Settings > SSH and GPG keys
   - Add a new SSH key (Authentication key)
   - Also add it as a Signing key

3. The `.gitconfig` is already configured to use SSH signing:
```ini
[user]
    signingkey = ~/.ssh/id_ed25519.pub
[gpg]
    format = ssh
[commit]
    gpgsign = true
```

## DNS Configuration

DNS is configured via systemd-resolved to use Cloudflare DNS (1.1.1.1):
- Configuration: `etc/systemd/resolved.conf.d/cloudflare.conf`
- Includes IPv4 (1.1.1.1, 1.0.0.1) and IPv6 (2606:4700:4700::1111, 2606:4700:4700::1001)
- DNSSEC enabled
- DNS-over-TLS opportunistic mode

## Ghostty Terminal

Ghostty is configured as the default terminal with:
- Font: JetBrains Mono 12pt
- Default fullscreen mode
- Custom keybindings matching previous terminal setup:
  - `Ctrl+T`: New tab
  - `Ctrl+V`: Copy to clipboard
  - `Ctrl+B`: Paste from clipboard
  - `Alt+Left/Right`: Switch tabs
  - `Ctrl+W`: Close tab

Configuration file: `ghostty/config`

## Swap
- Create swap file if not already done
```bash
make swap size=8G
```


## Ntp
- sudo timedatectl set-timezone My/Timezone

## Hostname (if needed)
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
    - gtk title bar by velitasali OR no titlebar when maximized OR pixelsaver
    - just perfection by JustPerfection
    - escape overview by rael
    - start overlay in application view by hex_cz or tmk
    - alphabetical app grid by stuartheyhurst
    - sound output device chooser by kgshank
    - lock screen background by sun_wang (optional)
    - User Themes by fmuellner
    - alttab-scroll-workaround by lucasresck

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

## scaling issue
- either use gnome on xorg at login
- use wayland but use large resolution and scale down