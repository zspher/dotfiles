{pkgs, ...}: {
  imports = [
    ./clipboard.nix
  ];
  home.packages = with pkgs; [
    libnotify
    python3
    xdotool
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [
      "DISPLAY"
      "HYPRLAND_INSTANCE_SIGNATURE"
      "WAYLAND_DISPLAY"
      "XDG_CURRENT_DESKTOP"
      "QT_QPA_PLATFORM"
    ];
    settings = {
      source = ["~/.config/hypr/monitors.conf"];
      env = ["QT_QPA_PLATFORM,wayland"];
      input = {
        kb_layout = "us";
        kb_options = "caps:swapescape";
        follow_mouse = 1;

        touchpad.natural_scroll = true;

        scroll_method = "on_button_down";
        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb($mauveAlpha) rgb($blueAlpha) 60deg";
        "col.inactive_border" = "rgb($mantleAlpha)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };

        drop_shadow = false;
        shadow_range = 8;
        shadow_render_power = 2;
        shadow_offset = "2 3";
        "col.shadow_inactive" = "rgb($crustAlpha)";
        "col.shadow" = "rgb($mauveAlpha)";
      };

      animations = {
        enabled = true;

        bezier = [
          "easeInSine, 0.12, 0, 0.39, 0"
          "easeOutSine, 0.61, 1, 0.88, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 7, easeOutExpo"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, easeOutSine"
          "workspaces, 1, 5, default"
        ];
      };

      dwindle.pseudotile = true;
      dwindle.preserve_split = true;
      master.new_is_master = true;

      gestures.workspace_swipe = true;

      group = {
        "col.border_active" = "rgb($mauveAlpha) rgb($blueAlpha) 60deg";
        "col.border_inactive" = "rgb($surface0Alpha)";
        "col.border_locked_active" = "rgb($blueAlpha)";
        "col.border_locked_inactive" = "rgb($mantleAlpha)";

        groupbar = {
          height = 1;
          render_titles = false;
          "col.active" = "rgb($mauveAlpha)";
          "col.inactive" = "rgb($surface0Alpha)";
          "col.locked_active" = "rgb($blueAlpha)";
          "col.locked_inactive" = "rgb($mantleAlpha)";
        };
      };

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        vrr = 1;
        vfr = true;
        force_default_wallpaper = 0;
      };

      windowrulev2 = [
        "bordercolor rgb($skyAlpha), floating:1"
        "bordercolor rgb($blueAlpha), fullscreen:1"
        "bordercolor rgb($overlay2Alpha), xwayland:1, floating:0, fullscreen:0"

        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"

        "workspace 1, class:obsidian"
        "workspace 2, class:Brave-browser"
        "workspace 3, class:Code"
        "workspace 3, class:kitty"
        "workspace 4, class:WebCord"

        "float, title:^(Floating Window \- Show Me The Key)$"
        "noborder, title:^(Floating Window \- Show Me The Key)$"
        "move 100%-320 100%-200, title:^(Floating Window \- Show Me The Key)$"
        "nofocus, title:^(Floating Window \- Show Me The Key)$"
        "noanim, title:^(Floating Window \- Show Me The Key)$"
        "pin, title:^(Floating Window \- Show Me The Key)$"

        "float, title:^(Unlock Database \- KeePassXC)$"

        "float, class:^(net.code\-industry.masterpdfeditor4)$"
        "tile, title:^(.*Master PDF Editor.*)$"
      ];

      layerrule = [
        "noanim, ^(rofi)$"
        "ignorezero, ^(rofi)$"
        "blur, ^(rofi)$"
        "noanim, ^(anyrun)$"
        "blur, ^(anyrun)$"
      ];

      ## keybinds

      "$mainMod" = "SUPER";
      "$terminal" = "kitty -1 tmux new -As0";
      "$file_manager" = "dolphin";
      "$notification_manager" = "swaync-client -t -sw";
      "$screen_shot" = "pkill rofi || ~/.config/rofi/bin/screenshot.sh";
      "$runner" = "pkill anyrun || anyrun";
      "$power_menu" = "pkill rofi || ~/.config/rofi/bin/powermenu.sh";

      bind = [
        # * === apps === * #
        "CTRL ALT, T, exec, $terminal"
        "ALT, SPACE, exec, $runner"
        "$mainMod, E, exec, $file_manager"
        "$mainMod, N, exec, $notification_manager"
        "$mainMod SHIFT, S, exec, $screen_shot"
        "CTRL ALT, Delete, exec, $power_menu"
        "$mainMod SHIFT, Q, exit, "
        "$mainMod, P, exec, [float] nwg-displays"

        # * === Window Management === * #
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, Q, exec, ~/.config/hypr/scripts/close_window.sh "
        "$mainMod, F, togglefloating, "
        "$mainMod, M, fullscreen, 1" # monocle layout
        "$mainMod SHIFT, F, fullscreen, 0" # true fullscreen
        "$mainMod, T, exec, ~/.config/hypr/scripts/toggle_tile_layout.sh" # toggle master, dwindle
        "$mainMod, C, centerwindow"

        # Special Workspace
        "$mainMod, A, togglespecialworkspace"
        "$mainMod CTRL, A,  exec, ~/.config/hypr/scripts/window_special.sh -t"
        "$mainMod SHIFT, A, exec, ~/.config/hypr/scripts/window_special.sh -f"

        # toggle group
        "$mainMod, G, togglegroup"
        "$mainMod, I, lockactivegroup, toggle"
        "$mainMod, code:35, changegroupactive, f"
        "$mainMod, code:34, changegroupactive, b"

        # dwindle
        "$mainMod SHIFT, P, pseudo,"
        "$mainMod, S, togglesplit,"

        # master
        "$mainMod, S, layoutmsg, swapwithmaster"
        "$mainMod SHIFT, M, layoutmsg, focusmaster"

        # pin
        "CTRL ALT, P, pin,"

        # * === Special Modes === * #
        "$mainMod, F1, exec, ~/.config/hypr/scripts/gamemode.sh"

        # * === Move Focus === * #
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, u"
        "$mainMod, K, movefocus, d"

        # * === Move Window === * #
        "$mainMod SHIFT, H, movewindoworgroup, l"
        "$mainMod SHIFT, L, movewindoworgroup, r"
        "$mainMod SHIFT, J, movewindoworgroup, u"
        "$mainMod SHIFT, K, movewindoworgroup, d"

        # * === Switch Workspace === * #

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod ALT, L, workspace, e+1"
        "$mainMod ALT, H, workspace, e-1"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # * === Move to Workspace === * #
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod CTRL, L, movetoworkspace, r+1"
        "$mainMod CTRL, H, movetoworkspace, r-1"
      ];

      bindl = [
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioPause, exec, playerctl pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioMute, exec, ~/.config/hypr/scripts/volume.py -m"
        ", XF86MonBrightnessDown, exec, ~/.config/hypr/scripts/brightness.py -d 5"
        ", XF86MonBrightnessUp, exec, ~/.config/hypr/scripts/brightness.py -i 5"
      ];

      bindle = [
        ", XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volume.py -d 5"
        ", XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volume.py -i 5"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
    extraConfig = ''
      # * =========  Resize window  ========= * #

      bind = $mainMod, R, submap, resize
      submap = resize
          binde = , H, resizeactive, -20 0
          binde = , L, resizeactive, 20 0
          binde = , J, resizeactive, 0 -20
          binde = , K, resizeactive, 0 20
      bind = , escape, submap, reset
      submap = reset
    '';
  };

  xdg.configFile = {
    "hypr/themes".source = ./themes;
    "hypr/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
