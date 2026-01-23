{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  networking = {
    hostName = "rex";
    networkmanager = {
      enable = true;
    };
  };

  system.stateVersion = "25.05";
}
