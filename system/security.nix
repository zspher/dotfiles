{ ... }:
{
  users.users = {
    root.hashedPassword = "!";
  };

  services.openssh.settings.PasswordAuthentication = false;

  security = {
    polkit.enable = true;
    # useful for pipewire
    rtkit.enable = true;

    # NOTE: sudo-rs breaks certain apps like
    #       - KDE partitionmanager (when using external ssd)
    #       so use default sudo for now
    #       probably related to `-E`
    # sudo-rs.enable = true;

    pam.services.hyprlock = { };
  };
}
