{ pkgs, ... }:
{
  imports = [
    ./brave.nix
    ./vesktop.nix
  ];
  home.packages = with pkgs; [
    inetutils
    qbittorrent
    yt-dlp
  ];
}
