{ pkgs, ... }:
{
  programs.walker = {
    enable = true;
    package = pkgs.walker;
    # runAsService = true;
    config = {
      ignore_mouse = true;
      terminal = "kitty";

      activation_mode = {
        labels = "12345678";
        use_alt = true;
      };
      builtins = {
        calc.prefix = "=";
        runner.prefix = ">";
      };

      disabled = [
        "finder"
        "windows"
      ];
      list.max_items = 20;
    };
  };
  home.packages = [ pkgs.libqalculate ];
}
