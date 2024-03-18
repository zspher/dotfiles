{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      energy_performance_preference = "performance";
      turbo = "auto";
    };
    battery = {
      governor = "powersave";
      energy_performance_preference = "power";
      turbo = "auto";
    };
  };
}
