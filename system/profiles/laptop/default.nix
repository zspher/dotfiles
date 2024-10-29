{ pkgs, ... }:
{
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../misc.nix
    ../../security.nix
    ../../user.nix

    ../../programs
    ../../programs/blueman.nix
    ../../programs/container.nix
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
    ../../networking/tailscale.nix
  ];

  networking.hostName = "ls-2100";
  hardware.i2c.enable = true;
  hardware.ckb-next.enable = true;
}
