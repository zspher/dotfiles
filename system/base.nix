{
  pkgs,
  data,
  ...
}: let
  inherit (data) username keys hostname;
in {
  import = [
    /etc/nixos/hardware-configuration.nix
  ];
  networking.hostName = hostname;
  users.users = {
    "${username}" = {
      initialPassword = "defaultPass";
      isNormalUser = true;
      openssh.authorizedKeys = {inherit keys;};
      extraGroups = ["wheel" "networkmanager"];
    };
  };
  nixpkgs = {
    overlays = [];
    config.allowUnfree = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    home-manager
  ];
  services = {
    openssh.enable = true;
  };
}
