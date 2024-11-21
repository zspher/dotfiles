{ pkgs, ... }:
{
  home.packages = with pkgs; [
    calibre
    # libreoffice-fresh # TODO: see https://github.com/NixOS/nixpkgs/issues/357387
    masterpdfeditor4
    obsidian
    kdePackages.okular
    simple-scan
    vscode-fhs
  ];
}
