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
    ../../system/zswap.nix

    ../../system/optional/keyd
    ../../system/optional/tlp
    ../../system/optional/upower
    ../../system/optional/brightnessctl
    ../../system/optional/steam
    ../../system/optional/impermanence

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
      ensureProfiles = {
        environmentFiles = [
          config.sops.secrets."wifi/home/ssid".path
          config.sops.secrets."wifi/home/psk".path
          config.sops.secrets."wifi/home-5g/ssid".path
          config.sops.secrets."wifi/home-5g/psk".path
        ];
	profiles = {
          "$HOME_SSID" = {
            connection = {
              id = "$HOME_SSID";
              type = "wifi";
              autoconnect = false;
            };
            wifi = {
              mode = "infrastructure";
              ssid = "$HOME_SSID";
            };
            wifi-security = {
              key-mgmt = "sae";
              psk = "$HOME_PSK";
            };
            ipv4 = {
              method = "auto";
            };
          };
          "$HOME_SSID_5G" = {
            connection = {
              id = "$HOME_SSID_5G";
              type = "wifi";
              autoconnect = true;
            };
            wifi = {
              mode = "infrastructure";
              ssid = "$HOME_SSID_5G";
            };
            wifi-security = {
              key-mgmt = "sae";
              psk = "$HOME_PSK_5G";
            };
            ipv4 = {
              method = "auto";
            };
          };
        };
      };
    };
  };

  system.stateVersion = "25.05";
}
