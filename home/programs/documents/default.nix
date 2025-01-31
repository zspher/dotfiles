{ pkgs, self, ... }:
{
  imports = [
    ./dbeaver.nix
  ];
  home.packages = with pkgs; [
    anki
    calibre
    libreoffice-fresh
    masterpdfeditor4
    obsidian
    kdePackages.okular
    (self.packages.${pkgs.system}.shrinkpdf)
    simple-scan
    vscode-fhs
  ];
}
