{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  chromium = config.systemSettings.chromium.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{

  options.systemSettings.chromium = {
    enable = lib.mkEnableOption "Enable chromium";
  };

  config = lib.mkIf chromium {
    hm = lib.mkIf homeManager {
      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
      };
    };
  };
}
