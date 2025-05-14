{ pkgs, ... }:
{
  imports = [
    ./brave.nix
    ./vesktop.nix
  ];
  home.packages = with pkgs; [
    qbittorrent
    yt-dlp
  ];
}
