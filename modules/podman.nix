{
  pkgs,
  lib,
  config,
  baseVars,
  ...
}:
let
  podman = config.systemSettings.podman.enable;
in
{

  options.systemSettings.podman = {
    enable = lib.mkEnableOption "Enable podman daemon";
  };

  config = lib.mkIf podman {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };
    environment.systemPackages = with pkgs; [ podman-compose ];

    users.groups.podman.members = [ baseVars.username ];
  };
}
