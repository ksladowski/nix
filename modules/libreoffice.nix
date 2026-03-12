{
  pkgs,
  lib,
  config,
  ...
}:
let
  libreoffice = config.systemSettings.libreoffice.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf libreoffice {
    hm = lib.mkIf homeManager {
      home = {
        packages = with pkgs; [
          libreoffice-qt
          hunspell
          hunspellDicts.en_US
        ];
      };
    };
  };
}
