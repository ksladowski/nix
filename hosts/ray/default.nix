{ inputs, outputs, ... }:
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

    ../../system/optional/keyd
    ../../system/optional/tlp
    ../../system/optional/upower
    ../../system/optional/brightnessctl
    ../../system/optional/steam

    ../../theming/stylix.nix

  ];

  networking = {
    hostName = "ray";
    networkmanager.enable = true;
  };

  system.stateVersion = "25.05";
}
