{pkgs, ...}: {
  services.xserver.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "sddm-corners";
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    (pkgs.callPackage ../../modules/packages/sddm-corners-theme {})
  ];
}
