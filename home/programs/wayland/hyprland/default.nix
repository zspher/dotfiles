{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [ ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    configType = "lua";
  };

  xdg.configFile = {
    "hypr/hyprland.lua".source = lib.mkForce ./hyprland.lua;
    "hypr/apps.lua".text =
      let
        attrs = lib.filterAttrs (
          k: v: builtins.substring 0 1 k == "$"
        ) config.wayland.windowManager.hyprland.settings;

        data = builtins.concatStringsSep "\n  " (
          lib.mapAttrsToList (k: v: "${builtins.replaceStrings [ "$" ] [ "" ] k} = \"${v}\",") attrs
        );
      in
      ''
        local M = {
          ${data}
        }
        return M
      '';
    "hypr/.luarc.json" = lib.mkForce {
      text = builtins.toJSON {
        workspace.library = [ "${pkgs.hyprland}/share/hypr/stubs" ];
        diagnostics.globals = [ "hl" ];
      };
    };
  };
}
