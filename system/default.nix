{pkgs, ...}: {
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
  hardware.enableRedistributableFirmware = true;
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    home-manager
  ];
  networking.networkmanager.enable = true;
  services = {
    openssh.settings.PermitRootLogin = "no";
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
  users.users = {
    root.hashedPassword = "!";
  };
}
