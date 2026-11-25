{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.calibre = {
    enable = true;
  };
  home.sessionVariables.CALIBRE_USE_SYSTEM_THEME = 1;

  xdg.configFile."calibre/dl/Vimstyle.zip" = {
    source = (
      pkgs.fetchurl {
        url = "https://github.com/elementdavv/calibre_vimstyle/releases/download/v0.1.0/Vimstyle_0.1.0.zip";
        hash = "sha256-XK+/aP9Ah7J/qb/dH9VlSnXUd6ppGeD4PwoRZmHO5Cg=";
        name = "calibre-vimstyle";
      }
    );
    onChange =
      let
        fl = "${config.xdg.configHome}/calibre/dl/Vimstyle.zip";
      in
      ''
        ${lib.getExe' pkgs.calibre "calibre-customize"} -a ${fl}
      '';
  };
}
