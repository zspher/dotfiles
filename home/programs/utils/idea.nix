{ pkgs, ... }:
{

  home.packages = with pkgs; [
    jetbrains.idea
  ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus
  '';
}
