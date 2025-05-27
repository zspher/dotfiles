{ pkgs, ... }:
{
  services.gnome-keyring.enable = true;
  home.packages = [ pkgs.gcr ];
  xdg.portal.config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
}
