{ pkgs, ... }:
{
  programs.walker = {
    enable = true;
    package = pkgs.walker;
    # runAsService = true;
    config = {
      ignore_mouse = true;
      activation_mode.labels = "12345678";
      activation_mode.use_alt = true;
      builtins.calc.prefix = "=";
      terminal = "kitty";

      disabled = [
        "finder"
        "runner"
        "windows"
      ];
      list.max_items = 20;
    };
  };
  home.packages = [ pkgs.libqalculate ];
}
