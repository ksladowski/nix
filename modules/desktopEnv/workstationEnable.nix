{
  lib,
  ...
}:
{
  options.systemSettings.workstation = {
    enable = lib.mkEnableOption "Enable desktop environment";
  };
}
