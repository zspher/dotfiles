{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    grimblast
    libnotify
    procps
    qimgv
    libsForQt5.kimageformats # avif, xcf, jxl in qimgv
    rofimoji

    (rofi-wayland.override {
      plugins = with pkgs; [
        inputs.rofi-plugins.packages.${pkgs.system}.rofi-websearch
        rofi-calc
      ];
    })
  ];
  xdg.configFile = {
    "rofi/share" = {
      source = lib.cleanSourceWith {
        src = ./share;
        filter =
          path: type:
          if config.theme.catppuccin.rofi.enable then builtins.baseNameOf path != "theme.rasi" else true;
      };
      recursive = true;
    };
    "rofi/bin" = {
      source = ./bin;
      recursive = true;
    };
    "rofi/config.rasi".source = ./config.rasi;
    "rofi/themes" = {
      source = ./themes;
      recursive = true;
    };
  };
}
