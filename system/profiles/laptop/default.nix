{pkgs, ...}: {
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../fonts.nix
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
    ../../programs/usisks.nix
    ../../programs/vm.nix

    ../../networking
    # ../../networking/openssh.nix
    ../../networking/syncting.nix
  ];

  networking.hostName = "ls-2100";
}
