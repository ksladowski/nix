{
  lib,
  ...
}:
{
  options.systemSettings.desktopEnv = {
    enable = lib.mkEnableOption "Enable desktop environment";
  };
}
