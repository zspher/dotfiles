{
  config,
  data,
  ...
}: let
  inherit (data) username;
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
}
