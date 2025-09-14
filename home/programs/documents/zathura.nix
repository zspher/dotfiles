{ pkgs, ... }:
{
  programs.zathura = {
    enable = true;
    options = {
      recolor-keephue = true;
      selection-clipboard = "clipboard";
    };
  };
}
