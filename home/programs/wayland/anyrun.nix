{ inputs, pkgs, ... }:
{
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.${pkgs.system}.anyrun;
    config = {
      layer = "top";
      y.fraction = 0.2;
      ignoreExclusiveZones = true;

      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        websearch
        applications
        rink
        symbols
        shell
      ];
    };

    extraConfigFiles = {
      "symbols.ron".text = ''
        Config(
          prefix: "?",
          max_entries: 12,
          symbols: {
            // "name": "text to be copied"
            "shrug": "¯\\_(ツ)_/¯",
          },
        )
      '';
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 10,
          terminal: Some(Terminal(
            command: "kitty",
            args: "{}",
          )),
        )
      '';
      "shell.ron".text = ''
        Config(
          prefix: ":",
          // Override the shell used to launch the command
          shell: None,
        )
      '';
      "websearch.ron".text = ''
        Config(
          prefix: "",
          engines: [
            Custom(
              name: "Unduck",
              url: "s.dunkirk.sh?q={}"
            )
          ]
        )
      '';
    };
  };
}
