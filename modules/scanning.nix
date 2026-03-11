{
  pkgs,
  lib,
  config,
  baseVars,
  ...
}:
let
  scanning = config.systemSettings.scanning.enable;
  workstation = config.systemSettings.workstation.enable;
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

    hm = lib.mkIf (homeManager && workstation) {
      home.packages = with pkgs; [
        simple-scan
      ];
    };
  };
}
