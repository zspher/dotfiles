{...}: {
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../fonts.nix
    ../../security.nix
    ../../user.nix

    ../../programs
    ../../programs/hyprland.nix
    ../../programs/steam.nix

    ../../services/blueman.nix
    ../../services/sddm.nix
    ../../services/usisks.nix
    ../../services/pipewire.nix

    ../../networking
    ../../networking/openssh.nix
    ../../networking/syncting.nix
  ];

  networking.hostName = "c-100";
}
