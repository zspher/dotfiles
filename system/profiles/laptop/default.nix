{ pkgs, ... }:
{
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../misc.nix
    ../../security.nix
    ../../theme.nix
    ../../user.nix

    ../../programs
    ../../programs/blueman.nix
    ../../programs/container.nix
    ../../programs/flatpak.nix
    ../../programs/hyprland.nix
    ../../programs/kanata.nix
    ../../programs/pipewire.nix
    ../../programs/power.nix
    ../../programs/sddm.nix
    ../../programs/steam.nix
    ../../programs/storage-dev.nix
    ../../programs/vm.nix

    ../../networking
    # ../../networking/openssh.nix
    ../../networking/syncting.nix
    # ../../networking/tailscale.nix
  ];

  networking.hostName = "ls-2100";
}
