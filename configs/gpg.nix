{pkgs, ...}: {
  programs.gpg.enable = true;

  services.gnome-keyring.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
}
