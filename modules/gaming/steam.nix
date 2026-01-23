{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.steam;
in
{

  options.systemSettings.steam = {
    enable = lib.mkEnableOption "Enable steam";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

    };
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    hm-persist.directories = lib.mkAfter [
      ".local/share/Steam"
    ];
  };
}
