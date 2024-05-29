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

    ../../services/auto-cpufreq.nix
    ../../services/blueman.nix
    ../../services/sddm.nix
    ../../services/usisks.nix

    ../../networking
    ../../networking/openssh.nix
    ../../networking/syncting.nix
  ];

  virtualisation.virtualbox.host.enable = true;
  environment.systemPackages = with pkgs; [
    vagrant
  ];
  virtualisation.virtualbox.guest.enable = true;
  networking.hostName = "ls-2100";
}
