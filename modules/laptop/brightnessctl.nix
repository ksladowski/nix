{
  pkgs,
  lib,
  config,
  ...
}:
let
  laptop = config.systemSettings.laptop.enable;
in
{
  config = lib.mkIf laptop {
    environment.systemPackages = with pkgs; [ brightnessctl ];
  };
}
