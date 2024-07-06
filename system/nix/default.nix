{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./substituters.nix
    ./nixpkgs.nix
  ];
  nix = {
    enable = true;
    package = pkgs.nix;
    gc =
      {
        automatic = true;
        options = "--delete-older-than 1w";
      }
      // (
        if builtins.hasAttr "home" config
        then {frequency = "weekly";}
        else {dates = "weekly";}
      );
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      use-xdg-base-directories = true;

      trusted-users = ["root" "@wheel"];
    };
  };
}
