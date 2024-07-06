{pkgs, ...}: {
  imports = [
    ./substituters.nix
    ./nixpkgs.nix
  ];
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;

      trusted-users = ["root" "@wheel"];
    };
  };
}
