{ pkgs, ... }:
{
  imports = [
    ./keybinds.nix
  ];

  xdg.configFile = {
    "hypr/hyprland.lua".source = ./hyprland.lua;
    "hypr/catppuccin.lua".source = ./catppuccin.lua;
    "hypr/apps.lua".text = ''
      local M = {
        clipboard_manager = "vicinae 'vicinae://launch/clipboard/history'",
        power_menu = "vicinae 'vicinae://launch/power'",
        runner = "vicinae toggle",
        screenshot = "vicinae 'vicinae://launch/@zspher/screenshot/screenshot'",
      }
      return M
    '';
    "hypr/.luarc.json" = {
      text = builtins.toJSON {
        workspace.library = [ "${pkgs.hyprland}/share/hypr/stubs" ];
        diagnostics.globals = [ "hl" ];
      };
    };
  };
}
