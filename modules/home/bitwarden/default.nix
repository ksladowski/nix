{ pkgs, ... }:
{

home = {
    packages = with pkgs; [
      bitwarden-desktop
      bitwarden-cli
    ];

    sessionVariables.SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
     
    };
}
