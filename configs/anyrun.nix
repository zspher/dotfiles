{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      x.fraction = 0.5;
      y.fraction = 0.3;
      width.absolute = 800;
      height.absolute = 100;
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "top";
      hidePluginInfo = true;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.symbols
        inputs.anyrun.packages.${pkgs.system}.dictionary
      ];
    };
    extraConfigFiles."applications.ron".text = ''
      Config(
          desktop_actions: false,
          max_entries: 5,
          terminal: Some("kitty"),
      )
    '';
  };
}
