{
  pkgs,
  lib,
  config,
  ...
}:
{

  config = lib.mkIf config.systemSettings.workstation.enable {
    hm = {
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
