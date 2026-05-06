{ ... }:
let
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
          color = "$mantle";
          path = "~/Pictures/wall.png";
        }
      ];

      input-field = [
        {
          outer_color = "$accent";
          inner_color = "$base";

          font_color = "$text";
          placeholder_text = ''<span foreground="##$textAlpha" font_family="${font_family}">password</span>'';

          check_color = "$overlay0";
          fail_color = "$red";
          capslock_color = "$yellow";

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
          color = "$text";
          font_size = 28;

          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          text = ''Hi there, <span foreground="##$peachAlpha">$USER</span>'';
          inherit font_family;
          color = "$text";

          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        {
          text = "⁙";
          inherit font_family;
          font_size = 15;
          color = "$text";

          rotate = 45.0;
          position = "0, 80";

          halign = "center";
          valign = "bottom";
        }
      ];

      image = [
        {
          path = "~/.face.icon";
          border_color = "$crust";

          position = "0, 0";
          size = 150;

          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
