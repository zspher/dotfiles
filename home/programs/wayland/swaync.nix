{...}: {
  programs.swaync = {
    enable = true;
    systemd.enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      control-center-layer = "top";
      control-center-positionX = "none";
      control-center-positionY = "top";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      control-center-width = 500;
      control-center-height = 600;
      fit-to-screen = false;

      layer = "overlay";
      layer-shell = true;
      cssPriority = "user";
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 32;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 8;
      timeout-low = 4;
      timeout-critical = 0;
      notification-window-width = 400;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = ["mpris" "title" "dnd" "notifications"];
      widget-config = {
        title = {
          text = "Notifications";
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          image-size = 100;
          image-radius = 12;
        };
      };
    };
  };
}
