{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    username = "faust";
    specialArgs = {inherit inputs self username;};
  in {
    pc = nixosSystem {
      inherit specialArgs;
      modules = [
        ./pc
        {system.stateVersion = "23.11";}
        {
          home-manager = {
            users."${username}".imports = [
              ../../home
              ../../home/profiles/full.nix
            ];
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
            users.faust.imports = [
              ../../home
              ../../home/profiles/minimal.nix
            ];
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
