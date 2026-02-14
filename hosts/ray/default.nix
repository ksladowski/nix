{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  systemSettings = {

    bluetooth.enable = true;
    wifi.enable = true;

    moonlight.enable = true;

    # Laptop
    brightnessctl.enable = true;
    keyd.enable = true;
    tlp.enable = true;
    upower.enable = true;

    nextcloud.enable = true;

  };
}
