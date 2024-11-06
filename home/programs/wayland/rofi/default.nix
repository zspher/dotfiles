{
  pkgs,
  lib,
  config,
  ...
}:
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
    source = lib.cleanSourceWith {
      src = ./share;
      filter =
        path: type:
        if config.theme.catppuccin.rofi.enable then builtins.baseNameOf path != "theme.rasi" else true;
    };
    recursive = true;
  };
  xdg.configFile."rofi/bin" = {
    source = ./bin;
    recursive = true;
  };
}
