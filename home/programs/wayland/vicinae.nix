{ pkgs, config, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    extensions = [
      (config.lib.vicinae.mkExtension {
        name = "screenshot";
        src =
          pkgs.fetchFromGitHub {
            owner = "zspher";
            repo = "vicinae_extensions";
            rev = "748ce4a2174f51c224c30a521d60b0834020d8f8";
            hash = "sha256-tNGpEqEQ20cfdg8plQtw5FR4QEMRFWXsHZY1J/B82oA=";
          }
          + "/screenshot";
      })
      # TODO: add websearch extension
    ];
    settings = {
      fallbacks = [ ];
      telemetry.system_info = false;
      providers.files.enabled = false;
      providers.files.autoIndexing = false;
      providers.snippets.enabled = false;
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$runner" = "vicinae toggle";
    "$clipboard_manager" = "vicinae 'vicinae://launch/clipboard/history'";
    "$power_menu" = "vicinae 'vicinae://launch/power'";
    "$screenshot" = "vicinae 'vicinae://launch/@zspher/screenshot/screenshot'";
  };
}
