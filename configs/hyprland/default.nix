{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      source = "~/.config/hypr/themes/mocha.conf";

      input = {
        kb_layout = "us";
        kb_options = "caps:swapescape";
        follow_mouse = 1;
      };

      general = {
        gaps_in = 5;
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod SHIFT, Q, exit,"
        "CTRL ALT, T, exec, kitty"
      ];
    };
  };

  xdg.configFile = {
    "hypr/themes".source = ./themes;
  };
}
