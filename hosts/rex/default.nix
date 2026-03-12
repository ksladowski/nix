{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  systemSettings = {

    shellEnvironment.enable = true;
    bluetooth.enable = true;
    amd.enable = true;

    steam.enable = true;
    sunshine.enable = true;

    wine.enable = true;
    hypervisor.enable = true;

    printing.enable = true;
    scanning.enable = true;

    superSlicer.enable = true;
    nextcloud-client.enable = true;
    element.enable = true;
    discord.enable = true;
    firefox.enable = true;

    homeManager.enable = true;
    impermanence.enable = true;

    nfsClient.enable = true;
    zswap.enable = true;
    bootloader.enable = true;
    networkManager.enable = true;
  };
}
