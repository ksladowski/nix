{
  pkgs,
  lib,
  config,
  ...
}:
let
  superSlicer = config.systemSettings.superSlicer.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{

  options.systemSettings.superSlicer = {
    enable = lib.mkEnableOption "Enable super slicer";
  };

  config = lib.mkIf superSlicer {

    hm = lib.mkIf homeManager {
      home.packages = with pkgs; [
        super-slicer-latest
      ];
    };
  };
}
