{...}: {
  imports = [
    ./copyq-fix.nix
  ];
  services.copyq.enable = true;
}
