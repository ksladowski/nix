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

    desktopEnv.enable = true;
    shellEnvironment.enable = true;

    bluetooth.enable = true;
    networkManager.enable = true;

    amd.enable = true;

    steam.enable = true;
    sunshine.enable = true;

    hypervisor.enable = true;
    podman.enable = true;

    nextcloudClient.enable = true;
    element.enable = true;
    discord.enable = true;
    firefox.enable = true;
    bitwarden.enable = true;
    remmina.enable = true;

    printing.enable = true;
    scanning.enable = true;

    nfsClient.enable = true;
    zswap.enable = true;
    bootloader.enable = true;
  };
}
