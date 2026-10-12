{ config, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGPG = config.services.gpg-agent.enable;
    };
  };
  catppuccin.lazygit.enable = true;
}
