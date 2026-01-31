{
  config,
  lib,
  ...
}:

let
  cfg = config.systemSettings.sunshine;
in
{
  options.systemSettings.sunshine = with lib; {
    enable = mkEnableOption "sunshine";
  };

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      openFirewall = true;
    };
    hm-persist.directories = [
      ".config/sunshine"
    ];

  };

}
