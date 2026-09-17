{ pkgs, lib, ... }:
{
  programs.calibre = {
    enable = true;
  };

  xdg.configFile."calibre/plugins/Vimstyle.zip" = {
    source = (
      pkgs.fetchurl {
        url = "https://github.com/elementdavv/calibre_vimstyle/releases/download/v0.1.0/Vimstyle_0.1.0.zip";
        hash = "sha256-XK+/aP9Ah7J/qb/dH9VlSnXUd6ppGeD4PwoRZmHO5Cg=";
        name = "calibre-vimstyle";
      }
    );
    onChange = ''
      ${lib.getExe' pkgs.calibre "calibre-customize"} --enable-plugin=Vimstyle
    '';
  };
}
