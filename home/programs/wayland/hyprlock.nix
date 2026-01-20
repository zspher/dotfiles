{
  config,
  lib,
  ...
}:
let
  ctp = {
    inherit (config.catppuccin) sources flavor;
  };
  c = builtins.mapAttrs (
    color: val: (builtins.substring 1 6 val.hex)
  ) (lib.importJSON "${ctp.sources.palette}/palette.json").${ctp.flavor}.colors;

  font_family = "CaskaydiaMono Nerd Font";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = false;
      };

      background = [
        {
          color = "rgb(${c.mantle})";
          path = "~/Pictures/wall.png";
        }
      ];

      input-field = [
        {
          outer_color = "rgb(${c.${config.catppuccin.accent}})";
          inner_color = "rgb(${c.base})";

          font_color = "rgb(${c.text})";
          placeholder_text = ''<span foreground="##${c.text}" font_family="${font_family}">password</span>'';

          check_color = "rgb(${c.overlay0})";
          fail_color = "rgb(${c.red})";
          capslock_color = "rgb(${c.yellow})";

          fade_on_empty = false;
          outline_thickness = 2;
          rounding = 20;
          size = "200, 40";

          position = "0, -120";
        }
      ];

      label = [
        {
          text = "<span>- $TIME -</span>";
          inherit font_family;
          color = "rgb(${c.text})";
          font_size = 28;

          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          text = ''Hi there, <span foreground="##${c.peach}">$USER</span>'';
          inherit font_family;
          color = "rgb(${c.text})";

          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        {
          text = "⁙";
          inherit font_family;
          font_size = 15;
          color = "rgb(${c.text})";

          rotate = 45.0;
          position = "0, 80";

          halign = "center";
          valign = "bottom";
        }
      ];

      image = [
        {
          path = "~/.face.icon";
          border_color = "rgb(${c.crust})";

          position = "0, 0";
          size = 150;

          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
