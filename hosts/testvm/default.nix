{ inputs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix

    ../../users/kevin

    ../../system/common

    ../../system/bootloader.nix
    ../../system/greetd.nix
    ../../system/zswap.nix

    ../../system/optional/impermanence

    ../../theming/stylix.nix

  ];

  networking = {
    hostName = "testvm";
    networkmanager = {
      enable = true;
    };
  };

  system.stateVersion = "25.05";
}
