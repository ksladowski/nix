{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.jackify;
in
{

  options.systemSettings.jackify = {
    enable = lib.mkEnableOption "Enable jackify";
  };

  config = lib.mkIf cfg.enable {
    hm.home.packages = [
      inputs.jackify.packages.${pkgs.system}.default
    ];
  };
}
