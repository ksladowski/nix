{ inputs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord.enable = false; # don't want normal discord client
    vesktop.enable = true;
  };
}
