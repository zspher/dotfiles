{pkgs, ...}: {
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../fonts.nix
    ../../security.nix
    ../../user.nix

    ../../programs
    ../../programs/hyprland.nix
    ../../programs/steam.nix
    ../../programs/vm.nix

    ../../services/power.nix
    ../../services/blueman.nix
    ../../services/sddm.nix
    ../../services/usisks.nix
    ../../services/pipewire.nix
    ../../services/kanata.nix

    ../../networking
    # ../../networking/openssh.nix
    ../../networking/syncting.nix
  ];

  networking.hostName = "ls-2100";
}
