{pkgs, ...}: {
  imports = [
    ./brave.nix
  ];
  home.packages = with pkgs; [
    cloudflare-warp
    inetutils
    qbittorrent
    webcord
    yt-dlp
  ];
}
