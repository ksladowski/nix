{ lib, config, ... }:
{
  config = lib.mkIf config.systemSettings.workstation.enable {
    hm = {

      # TODO plugins overlay
      # https://github.com/lordkekz/nix-yazi-plugins
      programs.yazi = {
        enable = true;
        enableFishIntegration = true;
        shellWrapperName = "yazi";
        settings = {
          mgr = {
            show_hidden = true;
          };
        };
      };
    };
  };
}
