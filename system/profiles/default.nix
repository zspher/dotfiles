{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    username = "faust";
    specialArgs = {inherit inputs self username;};
    inherit (import ../../home/profiles/config.nix) homeImports;
  in {
    pc = nixosSystem {
      inherit specialArgs;
      modules = [
        ./pc
        {system.stateVersion = "23.11";}
        {
          home-manager = {
            users."${username}".imports = homeImports.desktop;
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
    pi = nixosSystem {
      inherit specialArgs;
      modules = [
        ./pi
        {system.stateVersion = "23.11";}
        {
          home-manager = {
            users.faust.imports = homeImports.minimal;
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
