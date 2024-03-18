{...}: {
  imports = [
    ./mdns.nix
    ./network-manager.nix
    ./pipewire.nix
  ];
  networking.nameservers = ["1.1.1.1"];
}
