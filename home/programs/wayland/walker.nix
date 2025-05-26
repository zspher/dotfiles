{ pkgs, ... }:
{
  programs.walker = {
    enable = true;
    package = pkgs.walker;
    # runAsService = true;
    config = {
      ignore_mouse = true;
      terminal = "kitty";
      # as_window = true; # for debugging

      activation_mode.labels = "12345678";

      builtins = {
        calc.prefix = "=";
        runner.prefix = ">";
      };

      keys = {
        trigger_labels = "lalt";
        next = [
          "ctrl j"
          "down"
        ];
        prev = [
          "ctrl k"
          "up"
        ];
        toggle_exact_search = [ "ctrl m" ];
      };

      disabled = [
        "ai"
        "finder"
      ];
    };
  };
  home.packages = [ pkgs.libqalculate ];
}
