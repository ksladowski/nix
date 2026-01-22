{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.super-slicer;
in
{

  options.systemSettings.super-slicer = {
    enable = lib.mkEnableOption "Enable super-slicer";
  };

  config = lib.mkIf cfg.enable {

    hm = {
      hm.home.packages = with pkgs; [
        super-slicer-latest
      ];
    };
  };
}
