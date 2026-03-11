{
  pkgs,
  baseVars,
  lib,
  config,
  ...
}:
let
  printing = config.systemSettings.printing.enable;
in
{

  options.systemSettings.printing = {
    enable = lib.mkEnableOption "Enable CUPS";
  };

  config = lib.mkIf printing {
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
