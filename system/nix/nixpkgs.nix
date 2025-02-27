{
  lib,
  self,
  inputs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      # (final: prev: {
      #   kdePackages = prev.kdePackages.overrideScope (
      #     selfx: prevx: {
      #       kdeconnect-kde = prevx.kdeconnect-kde.overrideAttrs (oldAttrs: {
      #         cmakeFlags = oldAttrs.cmakeFlags ++ [
      #           "-DMDNS_ENABLED=OFF"
      #         ];
      #       });
      #     }
      #   );
      # })
      (final: prev: {
        biome = prev.biome.overrideAttrs (oldAttrs: {
          # FIX: https://github.com/NixOS/nixpkgs/issues/384795
          # from https://github.com/NixOS/nixpkgs/pull/384904
          cargoTestFlags = oldAttrs.cargoBuildFlags ++ [
            "-- --skip=commands::check::print_json"
            "--skip=commands::check::print_json_pretty"
            "--skip=commands::explain::explain_logs"
            "--skip=commands::format::print_json"
            "--skip=commands::format::print_json_pretty"
            "--skip=commands::format::should_format_files_in_folders_ignored_by_linter"
          ];
        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
