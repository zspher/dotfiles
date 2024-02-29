{...}: {
  imports = [
    ./hardware-config.nix

    ../../nix

    ../../fonts.nix
    ../../security.nix
    ../../user.nix

    ../../programs

    ../../networking
    ../../networking/openssh.nix
    ../../networking/syncting.nix
  ];
  networking.hostName = "ns-200";
}
