{
  flake.nixosModules = {
    catppuccin = import ./catppuccin;
    ascii-fix = import ./ascii-fix;
  };
}
