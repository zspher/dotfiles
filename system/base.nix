{
  pkgs,
  data,
  ...
}: let
  inherit (data) username keys hostname;
in {
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
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
    avahi = {
      ipv6 = true;
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      publish.enable = true;
      publish.userServices = true;
      publish.domain = true;
    };
  };
}
