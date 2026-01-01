{ inputs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix

    ../../users/kevin

    ../../system/common

    ../../system/bootloader.nix
    ../../system/greetd.nix
    ../../system/zsh.nix
    ../../system/zswap.nix

    ../../theming/stylix.nix

  ];

  sops.secrets."wifi/home/ssid" = {};
  sops.secrets."wifi/home/psk" = {};
  sops.secrets."wifi/home-5g/ssid" = {};
  sops.secrets."wifi/home-5g/psk" = {};

  networking = {
    hostName = "ray";
    networkmanager = {
      enable = true;
    };
  };

  system.stateVersion = "25.05";
}
