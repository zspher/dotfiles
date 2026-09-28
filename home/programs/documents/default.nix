{ pkgs, self, ... }:
{
  imports = [
    # ./dbeaver.nix
    ./zathura.nix
    ./calibre.nix
  ];
  home.packages = with pkgs; [
    libreoffice-qt-stable
    masterpdfeditor4
    obsidian
    (self.packages.${pkgs.stdenv.hostPlatform.system}.shrinkpdf)
    simple-scan
    vscode-fhs
  ];

  programs.anki.enable = true;
  catppuccin.anki.enable = true; # IFD
}
