if (builtins.pathExists /etc/nixos/config.nix)
then {inherit (import /etc/nixos/config.nix) username;}
else {
  username = "faust";
  #system = "aarch64-linux";
  system = "x86_64-linux";
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILgO9M53gSwDCnfPMUNctkcLmqwVtvnzskbjyGVspNp5 zspher@ls-2000"
  ];
}
