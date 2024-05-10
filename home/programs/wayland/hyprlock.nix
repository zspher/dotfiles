{config, ...}: let
  theme = ../../../modules/catppuccin/colors.nix;
  c = import theme {inherit (config.theme.catppuccin) variant;};

  font_family = "CaskaydiaMono Nerd Font";
in {
  programs.hyprlock = {
    enable = true;

    general = {
      disable_loading_bar = true;
      hide_cursor = true;
      no_fade_in = true;
      ignore_empty_input = false;
    };

    backgrounds = [
      {
        color = "rgb(${c.mantle})";
        path = "~/wall.png";
      }
    ];

    input-fields = [
      {
        outer_color = "rgb(${c.crust})";
        inner_color = "rgb(${c.base})";

        font_color = "rgb(${c.text})";
        placeholder_text = ''<span foreground="##${c.text}" font_family="${font_family}">password</span>'';

        check_color = "rgb(${c.overlay0})";
        fail_color = "rgb(${c.red})";
        capslock_color = "rgb(${c.yellow})";

        position = {
          x = 0;
          y = -70;
        };
      }
    ];

    labels = [
      {
        text = "$TIME";
        inherit font_family;
        color = "rgb(${c.text})";
        font_size = 30;
        position = {
          x = 0;
          y = 300;
        };
      }
      {
        text = ''Hi there, <span foreground="##${c.peach}">$USER</span>'';
        inherit font_family;
        color = "rgb(${c.text})";
        position = {
          x = 0;
          y = 250;
        };
      }
      {
        text = "⁙";
        inherit font_family;
        color = "rgb(${c.text})";
        font_size = 15;
        rotate = 45.0;
        position = {
          x = 0;
          y = 80;
        };
        halign = "center";
        valign = "bottom";
      }
    ];

    images = [
      {
        path = "~/avatar.png";
        border_color = "rgb(${c.crust})";
        position = {
          x = 0;
          y = 50;
        };
      }
    ];
  };
}
