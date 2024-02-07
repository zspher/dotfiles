{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      show-failed-attempts = true;
      clock = true;
      effect-blur = "5x2";
      font = "monospace";
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      datestr = "%b %d, %Y";
      fade-in = 0.1;
      ignore-empty-password = true;
      image = "$(swww query | awk '{print $NF}')";
    };
  };
}
