{
  lib,
  self,
  ...
}: {
  imports = [
    self.nixosModules.ascii-fix
  ];
  nixpkgs = {
    overlays = [
      (final: prev: {
        auto-cpufreq =
          prev.auto-cpufreq.overrideAttrs
          rec {
            _version = "1.9.9";
            version = lib.warnIf (prev.auto-cpufreq.version != _version) "Seems like auto-cpufreq has been updated!" _version;
            postInstall = ''
              # copy script manually
              cp scripts/cpufreqctl.sh $out/bin/cpufreqctl.auto-cpufreq
              # systemd service
              mkdir -p $out/lib/systemd/system
              cp scripts/auto-cpufreq.service $out/lib/systemd/system
            '';
            postPatch = ''
              substituteInPlace auto_cpufreq/core.py --replace '/opt/auto-cpufreq/override.pickle' /var/run/override.pickle
            '';
          };
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
    };
  };
}
