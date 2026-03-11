{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  systemSettings = {
    pelican.enable = true;
    cloudflared.enable = true;
    zswap.enable = true;
    bootloader.enable = true;
    impermanence.enable = true;
    networkManager.enable = true;
  };
}
