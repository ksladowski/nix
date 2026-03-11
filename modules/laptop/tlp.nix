{
  lib,
  config,
  ...
}:
let
  laptop = config.systemSettings.laptop.enable;
in
{
  config = lib.mkIf laptop {
    services.tlp.enable = true;
  };
}
