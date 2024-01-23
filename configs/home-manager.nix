{data, ...}: let
  inherit (data) username;
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
