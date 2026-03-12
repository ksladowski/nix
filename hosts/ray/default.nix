{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  systemSettings = {

    homeManager.enable = true;
    impermanence.enable = true;

    shellEnvironment.enable = true;
    laptop.enable = true;

    bluetooth.enable = true;
    wifi.enable = true;
    networkManager.enable = true;

    moonlight.enable = true;

    nextcloudClient.enable = true;
    element.enable = true;
    discord.enable = true;
    firefox.enable = true;

    scanning.enable = true;
    printing.enable = true;

    nfsClient.enable = true;
    zswap.enable = true;
    bootloader.enable = true;
  };
}
