# Misc

miscellaneous scripts, configs, dotfiles and desktop tweaks (_now with nix_)

## Important commands

- view nixos system history

```sh
nix profile history --profile /nix/var/nix/profiles/system
```

- delete nixos generations

```sh
sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
```

```sh
sudo nix store gc --debug
```

## Installation

### Preinstall

1. create the ff. GPT partitions:
   | file system | mount point | label | size |
   |- | - | - | - |
   | fat32 | /boot | boot | 512 MiB |
   | linux-swap | | swap | ram size |
   |btrfs | /, /home /nix /nix/store | nixos | the rest |
2. create btrfs subvolumes [1](https://nixos.wiki/wiki/Btrfs)

```sh
nix-shell -p btrfs-progs
mkdir -p /mnt
mount /dev/sdX2 /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
umount /mnt
```

3. mount the partitions and subvolumes

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
