{
  lib,
  ...
}:
{
  options.systemSettings.laptop = {
    enable = lib.mkEnableOption "Laptop specific modules";
  };
}
