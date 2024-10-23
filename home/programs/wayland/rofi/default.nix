{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grimblast
    libnotify
    procps
    qimgv
    libsForQt5.kimageformats # avif, xcf, jxl in qimgv
  ];
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland-unwrapped;
  xdg.configFile."rofi/share" = {
    source = ./share;
    recursive = true;
  };
  xdg.configFile."rofi/bin" = {
    source = ./bin;
    recursive = true;
  };
}
