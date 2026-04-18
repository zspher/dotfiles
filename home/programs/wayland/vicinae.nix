{ ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    settings = {
      fallbacks = [ ];
      providers.files.enabled = false;
    };
  };

  # TODO: add websearch extension
  wayland.windowManager.hyprland.settings = {
    "$runner" = "vicinae toggle";
    "$clipboard_manager" = "vicinae 'vicinae://launch/clipboard/history'";
    "$power_menu" = "vicinae 'vicinae://launch/power'";
    # "$screen_shot" = "" # TODO: add extension
  };
}
