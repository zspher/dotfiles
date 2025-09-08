{ pkgs, self, ... }:
{
  imports = [
    # ./dbeaver.nix
  ];
  home.packages = with pkgs; [
    anki
    calibre
    libreoffice-fresh
    masterpdfeditor4
    obsidian
    kdePackages.okular
    (self.packages.${pkgs.stdenv.hostPlatform.system}.shrinkpdf)
    simple-scan
    vscode-fhs
  ];

  home.sessionVariables.CALIBRE_USE_SYSTEM_THEME = 1;
}
