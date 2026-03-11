{
  pkgs,
  lib,
  config,
  ...
}:
let
  element = config.systemSettings.element.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{

  options.systemSettings.element = {
    enable = lib.mkEnableOption "Enable element";
  };

  config = lib.mkIf element {

    hm = lib.mkIf homeManager {
      home.packages = with pkgs; [
        element-desktop
      ];
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".config/Element"
      ];
    };
  };
}
