{
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.wifi;
in
{
  options.systemSettings.wifi = {
    enable = lib.mkEnableOption "Enable wifi with home profiles";
  };

  config = lib.mkIf cfg.enable {

    sops.secrets."wifi/home/ssid" = { };
    sops.secrets."wifi/home/psk" = { };
    sops.secrets."wifi/home-5g/ssid" = { };
    sops.secrets."wifi/home-5g/psk" = { };

    networking.networkmanager.ensureProfiles = {
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
}
