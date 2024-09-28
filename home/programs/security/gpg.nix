{
  config,
  pkgs,
  ...
}:
{
  programs.gpg.enable = true;
  programs.gpg.homedir = "${config.xdg.dataHome}/gnupg";

  services.gnome-keyring.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };
}
