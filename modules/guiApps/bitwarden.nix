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
          bitwarden-desktop
          bitwarden-cli
        ];

        sessionVariables.SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";

        persistence."/persist".directories = lib.mkAfter [
          ".config/Bitwarden"
        ];

      };

    };
  };
}
