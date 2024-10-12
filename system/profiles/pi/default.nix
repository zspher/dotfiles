{ ... }:
{
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../misc.nix
    ../../security.nix
    ../../user.nix

    ../../programs

    ../../networking
    ../../networking/openssh.nix
    ../../networking/syncting.nix
    ../../networking/tailscale.nix
  ];
  networking.hostName = "ns-200";
}
