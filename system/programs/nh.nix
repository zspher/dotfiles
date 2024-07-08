{...}: let
  inherit (import ../config.nix) username;
in {
  programs.nh = {
    enable = true;
    flake = "/home/${username}/dotfiles";
  };
}
