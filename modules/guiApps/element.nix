{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.element;
in
{

  options.systemSettings.element = {
    enable = lib.mkEnableOption "Enable element";
  };

  config = lib.mkIf cfg.enable {

    hm = {
      home.packages = with pkgs; [
        element-desktop
      ];
    };

    hm-persist = {
      directories = [
        ".config/Element"
      ];
    };
  };
}
