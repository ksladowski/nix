{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  systemSettings = {

    workstation.enable = true;
    laptop.enable = true;

    bluetooth.enable = true;
    wifi.enable = true;

    moonlight.enable = true;

    nextcloud-client.enable = true;
    element.enable = true;

  };
}
