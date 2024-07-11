{...}: {
  imports = [
    ./mdns.nix
    ./network-manager.nix
  ];
  networking.nameservers = ["1.1.1.1" "1.0.0.1"];
  networking.networkmanager.settings."global-dns-domain-*".servers = "1.1.1.1,1.0.0.1";
}
