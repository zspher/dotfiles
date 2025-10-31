{ pkgs, ... }:
let
  inherit (builtins) genList toString;
in
{
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      keybinds = {
        next = [
          "ctrl j"
          "Down"
        ];
        previous = [
          "ctrl k"
          "Up"
        ];
        toggle_exact_search = [ "ctrl m" ];
        quick_activate = genList (x: "alt ${toString (x + 1)}") 9;
      };
      providers.default = [
        "desktopapplications"
        "calc"
        "menus"
        "websearch"
      ];
    };
  };
  programs.elephant = {
    enable = true;
    installService = true;
  };
  home.packages = with pkgs; [
    libqalculate
    wl-clipboard
  ];
  wayland.windowManager.hyprland.settings = {
    "$runner" = "walker";
    "$clipboard_manager" = "walker -m 'clipboard'";
  };
  xdg.configFile."elephant/desktopapplications.toml".text = ''
    show_actions = true
  '';
}
