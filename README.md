<div align="center">

# Dotfiles

<img src="./home/programs/wayland/waybar/assets/nix-catppuccin-logo.svg" alt="NiXOS logo in Catppuccin colorscheme" width=250/>

miscellaneous scripts, configs, and dotfiles (_now with nix_)

![Neovim](https://img.shields.io/badge/Editor-Neovim-a6e3a1?style=flat-square&logo=neovim&logoColor=%23a6e3a1)
![Static Badge](https://img.shields.io/badge/NixOS-Unstable-89b4fa?style=flat-square&logo=nixos&logoColor=%2389b4fa)

</div>


- **Window Manager** • [hyprland](https://github.com/hyprwm/Hyprland)
- **Shell** • [fish](http://fishshell.com) w/ [starship](https://github.com/starship/starship)
- **Terminal** • [kitty](https://github.com/kovidgoyal/kitty)
- **Panel** • [waybar](https://github.com/Alexays/Waybar)
- **Notify Daemon** • [swaync](https://github.com/ErikReider/SwayNotificationCenter)
- **Launcher** • [rofi](https://github.com/davatorium/rofi)
- **Theme** • [Catppuccin Mocha](https://github.com/catppuccin/catppuccin)

## Files
- [home/](./home/) - home-manager user configurations
- [system/](./system/) - NixOS system configurations
- [modules/](./modules/) - custom nix modules
- [packages/](./packages/) - custom packages for nix

## Installation

<details>
<summary>install instructions</summary>

### Preinstall

1. create the ff. GPT partitions:

   | file system | mount point | label | size |
   |- | - | - | - |
   | fat32 | /boot | boot | 512 MiB |
   | linux-swap | | swap | ram size |
   |btrfs | /, /home /nix /nix/store | nixos | the rest |

2. reboot
3. create btrfs subvolumes [1](https://nixos.wiki/wiki/Btrfs)

    ```sh
    nix-shell -p btrfs-progs
    mkdir -p /mnt
    mount /dev/sdX2 /mnt
    btrfs subvolume create /mnt/root
    btrfs subvolume create /mnt/home
    btrfs subvolume create /mnt/nix
    umount /mnt
    ```

4. mount the partitions and subvolumes

    ```sh
    mount -o compress=zstd,subvol=root /dev/sdX2 /mnt
    mkdir /mnt/{home,nix}
    mount -o compress=zstd,subvol=home /dev/sdX2 /mnt/home
    mount -o compress=zstd,noatime,subvol=nix /dev/sdX2 /mnt/nix

    mkdir /mnt/boot
    mount /dev/sdX1 /mnt/boot
    ```

### Install

1. generate nix hardware configs

    ```sh
    nixos-generate-config --root /mnt
    ```

2. manually add mount options

    ```sh
    nano /mnt/etc/nixos/configuration.nix
    ```

3. install nixos

    ```sh
    nixos-install
    ```

4. clone / copy this repo and check if hardware config differs from `/mnt/etc/nixos/hardware-configuration.nix`

5. setup nixos

    ```sh
    sudo nixos-rebuild switch --flake .#pc
    ```

6. setup home-manager

    ```sh
    home-manager switch --flake .#basic
    ```

### Post-Install (Manual changes)

- [ ] set user password
- [ ] set timezone via `timedatectl`
- browser stuff
  - [ ] update dark reader to new ui
  - [ ] import stylus styles
- [ ] run Adwaita-for-steam install script
- [ ] select catppuccin theme from obs
- [ ] theme webcord
- [ ] keepassxc enable theme & settings
- [ ] copyq disable saving keepassxc passwords

</details>
