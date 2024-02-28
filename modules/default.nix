{
  flake.nixosModules = {
    catppuccin = import ./catppuccin;
    swaync = import ./swaync;
  };
}
