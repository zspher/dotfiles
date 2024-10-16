{ username, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 2 --nogcroots";
    flake = "/home/${username}/dotfiles";
  };
}
