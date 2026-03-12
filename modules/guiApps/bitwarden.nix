{
  pkgs,
  lib,
  config,
  ...
}:
let
  bitwarden = config.systemSettings.bitwarden.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  config = lib.mkIf bitwarden {

    hm = lib.mkIf homeManager {
      home = {
        packages = with pkgs; [
          bitwarden-desktop
          bitwarden-cli
        ];

        sessionVariables.SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
      };

    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".config/Bitwarden"
      ];
    };
  };
}
