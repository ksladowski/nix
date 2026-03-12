{
  pkgs,
  lib,
  config,
  baseVars,
  ...
}:
let
  scanning = config.systemSettings.scanning.enable;
  simpleScan = config.systemSettings.simpleScan.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{

  options.systemSettings.scanning = {
    enable = lib.mkEnableOption "Enable SANE";
  };

  config = lib.mkIf scanning {
    hardware.sane.enable = true;

    users.groups.scanner.members = [ baseVars.username ];
    users.groups.lp.members = [ baseVars.username ];

    hm = lib.mkIf (homeManager && simpleScan) {
      home.packages = with pkgs; [
        simple-scan
      ];
    };
  };
}
