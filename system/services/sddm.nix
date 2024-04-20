{
  pkgs,
  self,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-corners";
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    self.packages.${pkgs.system}.sddm-corners-theme
  ];
}
