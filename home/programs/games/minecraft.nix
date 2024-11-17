{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    (inputs.pollymc.packages.${pkgs.system}.pollymc.override {
      jdks = with pkgs; [
        jdk8
        jdk17
        jdk21
      ];
    })
  ];
}
