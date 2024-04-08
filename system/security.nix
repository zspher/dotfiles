{...}: {
  users.users = {
    root.hashedPassword = "!";
  };

  services.openssh.settings.PasswordAuthentication = false;

  security = {
    # useful for pipewire
    rtkit.enable = true;

  };
}
