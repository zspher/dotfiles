{ pkgs, ... }:
{
  imports = [
    ./brave.nix
  ];
  home.packages = with pkgs; [
    inetutils
    qbittorrent
    vesktop
    yt-dlp
  ];
}
