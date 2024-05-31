{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];
  services = {
    upower.enable = true;
    upower.percentageCritical = 5;
    upower.percentageAction = 4;

    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
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
  };
}
