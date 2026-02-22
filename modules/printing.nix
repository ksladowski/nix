{
  pkgs,
  baseVars,
  lib,
  config,
  ...
}:
{

  options.systemSettings.printing = {
    enable = lib.mkEnableOption "Enable CUPS";
  };

  config = lib.mkIf config.systemSettings.printing.enable {
    services.printing = {
      enable = true;
      drivers = [
        pkgs.cnijfilter2
      ];
    };

    hardware.printers = {
      ensurePrinters = [
        {
          name = "Canon_MX492";
          deviceUri = "usb://Canon/MX490%20series?serial=68E8EC&interface=1";
          model = "canonmx490.ppd";
        }
      ];
      ensureDefaultPrinter = "Canon_MX492";
    };

    users.groups.lpadmin.members = [ baseVars.username ];

  };
}
