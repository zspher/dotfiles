{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
    self.nixosModules.ascii-fix
  ];
  nixpkgs = {
    overlays = [
      inputs.waybar.overlays.default
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
    };
  };
}
