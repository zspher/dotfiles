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
    sudo-rs.enable = true;

    pam.services.hyprlock = { };
  };
}
