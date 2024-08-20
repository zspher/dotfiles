{...}: {
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../misc.nix
    ../../security.nix
    ../../user.nix

    ../../programs
    ../../programs/blueman.nix
    ../../programs/hyprland.nix
    ../../programs/pipewire.nix
    ../../programs/sddm.nix
    ../../programs/steam.nix
    ../../programs/storage-dev.nix

    ../../networking
    ../../networking/openssh.nix
    ../../networking/syncting.nix
  ];

  networking.hostName = "c-100";
}
