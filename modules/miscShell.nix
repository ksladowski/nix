{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.systemSettings.shellEnvironment.enable {
    hm = {

      home = {
        packages = with pkgs; [
          grc
          fd
          more
        ];
      };

      programs.bat.enable = true;

      programs.zoxide.enable = true;

      programs.htop.enable = true;

      programs.fzf.enable = true;
      programs.ripgrep.enable = true;

    };
  };
}
