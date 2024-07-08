{...}: let
  inherit (import ../config.nix) username;
in {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 2 --keep-since 3d --nogcroots";
    flake = "/home/${username}/dotfiles";
  };
}
