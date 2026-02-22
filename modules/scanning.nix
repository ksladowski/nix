{
  pkgs,
  lib,
  config,
  baseVars,
  ...
}:
{

  options.systemSettings.scanning = {
    enable = lib.mkEnableOption "Enable SANE";
  };

  config = lib.mkIf config.systemSettings.scanning.enable {
    hardware.sane.enable = true;

    users.groups.scanner.members = [ baseVars.username ];
    users.groups.lp.members = [ baseVars.username ];

    # TODO make this part conditional on workstation
    hm.home.packages = with pkgs; [
      simple-scan
    ];
  };
}
