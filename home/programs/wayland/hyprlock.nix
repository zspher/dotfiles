{config, ...}: let
  theme = ../../../modules/catppuccin/colors.nix;
  c = import theme {inherit (config.theme.catppuccin) variant;};

  font_family = "CaskaydiaMono Nerd Font";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = true;
        ignore_empty_input = false;
      };

      background = [
        {
          color = "rgb(${c.mantle})";
          path = "~/wall.png";
        }
      ];

      input-field = [
        {
          outer_color = "rgb(${c.crust})";
          inner_color = "rgb(${c.base})";

          font_color = "rgb(${c.text})";
          placeholder_text = ''<span foreground="##${c.text}" font_family="${font_family}">password</span>'';

          check_color = "rgb(${c.overlay0})";
          fail_color = "rgb(${c.red})";
          capslock_color = "rgb(${c.yellow})";

          size = "200, 50";

          position = "0, -70";
        }
      ];

      label = [
        {
          text = "$TIME";
          inherit font_family;
          color = "rgb(${c.text})";
          font_size = 30;

          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          text = ''Hi there, <span foreground="##${c.peach}">$USER</span>'';
          inherit font_family;
          color = "rgb(${c.text})";

          position = "0, 250";
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
          path = "~/avatar.png";
          border_color = "rgb(${c.crust})";

          position = "0, 50";
          size = 150;

          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
