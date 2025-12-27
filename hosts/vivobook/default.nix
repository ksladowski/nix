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

  ];

  networking = {
    hostName = "vivobook";
    networkmanager.enable = true;
  };

  system.stateVersion = "25.05";
}
