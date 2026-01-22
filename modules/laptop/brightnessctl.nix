{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.brightnessctl;
in
{

  options.systemSettings.brightnessctl = {
    enable = lib.mkEnableOption "Enable brightnessctl";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ brightnessctl ];
  };
}
