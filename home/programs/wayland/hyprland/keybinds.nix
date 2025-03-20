{ pkgs, ... }:
let
  close_window = pkgs.writeShellApplication {
    name = "close-window";
    runtimeInputs = [ pkgs.xdotool ];
    text = builtins.readFile ./scripts/close_window.sh;
  };
  brightness = pkgs.writers.writePython3 "brightness" {
    libraries = [ pkgs.libnotify ];
    flakeIgnore = [
      "E501"
    ];
  } (builtins.readFile ./scripts/brightness.py);
  volume = pkgs.writers.writePython3 "volume" {
    libraries = [ pkgs.libnotify ];
    flakeIgnore = [
      "E501"
    ];
  } (builtins.readFile ./scripts/volume.py);
  gamemode = pkgs.writeShellApplication {
    name = "gamemode";
    text = builtins.readFile ./scripts/gamemode.sh;
  };
  hyprtabs = pkgs.writeShellApplication {
    name = "hyprtabs";
    text = builtins.readFile ./scripts/hyprtabs.sh;
  };
in
{
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty -1 ";
      "$file_manager" = "dolphin";
      "$notification_manager" = "swaync-client -t -sw";
      "$screen_shot" = "~/.config/rofi/bin/screenshot.sh";
      "$runner" = "walker";
      "$power_menu" = "~/.config/rofi/bin/powermenu.sh";

      bind = [
        # * === apps === * #
        "CTRL SHIFT, escape, exec, $terminal btop"
        "CTRL ALT, T, exec, $terminal --class kitty-term"
        "ALT, SPACE, exec, $runner"
        "ALT, TAB, exec, $runner -m windows"
        "$mainMod, E, exec, $file_manager"
        "$mainMod, N, exec, $notification_manager"
        "$mainMod SHIFT, S, exec, $screen_shot"
        "CTRL ALT, Delete, exec, $power_menu"
        "$mainMod SHIFT, Q, exit, "
        "$mainMod, P, exec, [float] nwg-displays"

        # * === Window Management === * #
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, Q, exec, ${close_window}/bin/close-window "
        "$mainMod, F, togglefloating, "
        "$mainMod, M, fullscreen, 1" # monocle layout
        # "$mainMod, M, exec, ${hyprtabs}/bin/hyprtabs" # monocle layout
        "$mainMod SHIFT, F, fullscreen, 0" # true fullscreen
        "$mainMod, C, centerwindow"

        # Special Workspace
        "$mainMod, A, togglespecialworkspace"

        # toggle group
        "$mainMod, G, togglegroup"
        "$mainMod, I, lockactivegroup, toggle"
        "$mainMod, code:35, changegroupactive, f"
        "$mainMod, code:34, changegroupactive, b"

        # dwindle
        "$mainMod SHIFT, P, pseudo,"
        "$mainMod, T, togglesplit"
        "$mainMod, S, swapnext"

        # pin
        "CTRL ALT, P, pin,"

        # * === Special Modes === * #
        "$mainMod, F1, exec, ${gamemode}/bin/gamemode"

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
        "$mainMod SHIFT, A, movetoworkspacesilent, special"
        "$mainMod CTRL, L, movetoworkspace, r+1"
        "$mainMod CTRL, H, movetoworkspace, r-1"
      ];

      bindl = [
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioPause, exec, playerctl pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioMute, exec, ${volume} -m"
      ];

      bindle = [
        ", XF86AudioLowerVolume, exec, ${volume} -d 5"
        ", XF86AudioRaiseVolume, exec, ${volume} -i 5"
        ", XF86MonBrightnessDown, exec, ${brightness} -d 5"
        ", XF86MonBrightnessUp, exec, ${brightness} -i 5"
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
}
