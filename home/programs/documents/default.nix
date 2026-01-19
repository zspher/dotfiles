{ pkgs, self, ... }:
{
  imports = [
    # ./dbeaver.nix
    ./zathura.nix
  ];
  home.packages = with pkgs; [
    calibre
    libreoffice-fresh
    masterpdfeditor4
    obsidian
    (self.packages.${pkgs.stdenv.hostPlatform.system}.shrinkpdf)
    simple-scan
    vscode-fhs
  ];
  home.sessionVariables.CALIBRE_USE_SYSTEM_THEME = 1;

  programs.anki.enable = true;
}
