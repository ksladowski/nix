{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.systemSettings.shellEnvironment.enable {
    hm = {

      programs.lazygit = {
        enable = true;
        settings = {
          disableStartupPopups = true;
          git = {
            autoFetch = false;
          };
        };
      };

    };
  };
}
