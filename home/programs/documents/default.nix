{pkgs, ...}: {
  home.packages = with pkgs; [
    calibre
    libreoffice-fresh
    masterpdfeditor4
    obsidian
    okular
    simple-scan
    vscode-fhs
  ];
}
