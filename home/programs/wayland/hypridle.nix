{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = 60 * 20;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 60 * 20 + 2;
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'  ";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
        }
        {
          timeout = 60 * 30;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
