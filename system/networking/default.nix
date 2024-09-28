{ ... }:
{
  imports = [
    ./mdns.nix
    ./network-manager.nix
  ];
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
}
