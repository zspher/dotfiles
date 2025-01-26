{
  flake.homeManagerModules = {
    catppuccin = import ./catppuccin;
    vivid = import ./vivid;
    walker = import ./walker;
  };
}
