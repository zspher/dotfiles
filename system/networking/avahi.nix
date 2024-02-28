{...}: {
  services.avahi = {
    ipv6 = true;
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish.enable = true;
    publish.userServices = true;
    publish.domain = true;
  };
}
