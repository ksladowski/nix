{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.systemSettings.laptop.enable {
    environment.systemPackages = with pkgs; [ brightnessctl ];
  };
}
