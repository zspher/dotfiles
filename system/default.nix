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
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    home-manager
  ];
}
