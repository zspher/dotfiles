{ pkgs, ... }:
{
  home.packages = with pkgs; [
    calibre
    libreoffice-fresh
    masterpdfeditor4
    obsidian
    kdePackages.okular
    simple-scan
    vscode-fhs
  ];
}
