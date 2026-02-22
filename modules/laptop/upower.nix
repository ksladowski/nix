{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.systemSettings.laptop.enable {
    services.upower.enable = true; # Battery stuff
  };
}
