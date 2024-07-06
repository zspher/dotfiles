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
    self.packages.${pkgs.system}.sddm-corners-theme
  ];
}
