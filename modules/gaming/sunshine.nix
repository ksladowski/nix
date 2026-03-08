{
  pkgs,
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
      # TODO remove this once PR is merged into nixpkgs-unstable
      # https://nixpk.gs/pr-tracker.html?pr=493384
      package = pkgs.sunshine.override {
        boost = pkgs.boost187;
      };
    };
    hm-persist.directories = [
      ".config/sunshine"
    ];

  };

}
