{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.nixos-raspberrypi.lib) nixosSystemFull;
      inherit (import ../config.nix) username;
      specialArgs = {
        inherit inputs self username;
      };
    in
    {
      "c100" = nixosSystem {
        inherit specialArgs;
        modules = [
          ./pc
          { system.stateVersion = "23.11"; }
        ];
      };
      "ls2100" = nixosSystem {
        inherit specialArgs;
        modules = [
          ./laptop
          { system.stateVersion = "23.11"; }
        ];
      };
      "ns200" = nixosSystem {
        inherit specialArgs;
        modules = [
          ./pi
          { system.stateVersion = "25.11"; }
        ];
      };
    };
}
