{
  pkgs,
  lib,
  config,
  ...
}:
let
  steam = config.systemSettings.steam.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  options.systemSettings.steam = {
    enable = lib.mkEnableOption "Enable steam";
  };

  config = lib.mkIf steam {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

    };
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    environment.systemPackages = with pkgs; [
      vkd3d-proton
    ];

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".local/share/Steam"
      ];

    };
  };
}
