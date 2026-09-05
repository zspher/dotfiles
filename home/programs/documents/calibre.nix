{ pkgs, lib, ... }:
{
  programs.calibre = {
    enable = true;
  };

  xdg.configFile."calibre/plugins/Vimstyle.zip" = {
    source = (
      pkgs.fetchurl {
        url = "https://github.com/elementdavv/calibre_vimstyle/archive/refs/tags/v0.1.0.zip";
        hash = "sha256-1U85d0ZPmKhZa3bvtkpEJwYHEkwB1rqVsu2Ai8IHzWo=";
        name = "calibre-vimstyle";
      }
    );
    onChange = ''
      ${lib.getExe' pkgs.calibre "calibre-customize"} --enable-plugin=Vimstyle
    '';
  };
}
