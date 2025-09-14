{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    # package = pkgs.steam.override {
    #   # FIX: https://github.com/tkashkin/Adwaita-for-Steam/issues/316
    #   extraEnv.MESA_LOADER_DRIVER_OVERRIDE = "zink";
    # };
  };
  programs.gamemode.enable = true;
}
