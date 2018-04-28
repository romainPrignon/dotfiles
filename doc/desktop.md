# install gnome desktop
```bash
sudo apt install gnome-session gdm3
sudo dpkg-reconfigure gdm3
```

# remove unity desktop
```bash
sudo apt purge ubuntu-unity-desktop lightdm
sudo apt autoremove --purge
```