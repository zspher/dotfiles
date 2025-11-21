{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # inputs.hyprland.nixosModules.default
  ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    PROTON_ENABLE_WAYLAND = 1;
    GSK_RENDERER = "ngl";
  };
  environment.systemPackages = with pkgs; [
    kdePackages.qtwayland
  ];
}
