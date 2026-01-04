{ inputs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix

    ../../users/kevin

    ../../system/common

    ../../system/bootloader.nix
    ../../system/bluetooth.nix
    ../../system/greetd.nix
    ../../system/zsh.nix
    ../../system/zswap.nix

    ../../system/optional/steam
    ../../system/optional/virtualization
    ../../system/optional/impermanence

    ../../theming/stylix.nix

  ];

  networking = {
    hostName = "rex";
    networkmanager = {
      enable = true;
    };
  };

  system.stateVersion = "25.05";
}
