{ pkgs, ... }:
{
  home.packages = with pkgs; [
    anki
    calibre
    libreoffice-fresh
    masterpdfeditor4
    obsidian
    kdePackages.okular
    simple-scan
    vscode-fhs
  ];
}
