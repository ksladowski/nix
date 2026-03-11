{
  pkgs,
  lib,
  config,
  baseVars,
  ...
}:
let
  nextcloudClient = config.systemSettings.nextcloudClient.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{

  options.systemSettings.nextcloudClient = {
    enable = lib.mkEnableOption "Enable nextcloud client sync";
  };

  config = lib.mkIf nextcloudClient {

    sops.secrets."nextcloud/password" = {
      owner = "${baseVars.username}";
      mode = "0400";
    };
    sops.secrets."nextcloud/login" = {
      owner = "${baseVars.username}";
      mode = "0400";
    };
    sops.secrets."nextcloud/url" = {
      owner = "${baseVars.username}";
      mode = "0400";
    };

    hm = lib.mkIf homeManager {
      home.packages = with pkgs; [ nextcloud-client ];
      systemd.user = {
        services.nextcloud-autosync = {
          Unit = {
            Description = "Auto sync Nextcloud";
            After = "network-online.target";
          };
          Service = {
            Type = "simple";
            ExecStart = "${pkgs.writeShellScript "nextcloud-sync" ''
              ${pkgs.nextcloud-client}/bin/nextcloudcmd -h \
                --user "$(cat ${config.sops.secrets."nextcloud/login".path})" \
                --password "$(cat ${config.sops.secrets."nextcloud/password".path})" \
                --path /notes \
                /home/${baseVars.username}/Documents/notes \
                "$(cat ${config.sops.secrets."nextcloud/url".path})"
            ''}";
            TimeoutStopSec = "180";
            KillMode = "process";
            KillSignal = "SIGINT";
          };
          Install.WantedBy = [ "multi-user.target" ];
        };
        timers.nextcloud-autosync = {
          Unit.Description = "Automatic sync files with Nextcloud when booted up after 5 minutes then rerun every 60 minutes";
          Timer.OnBootSec = "5min";
          Timer.OnUnitActiveSec = "60min";
          Install.WantedBy = [
            "multi-user.target"
            "timers.target"
          ];
        };
        startServices = true;
      };
    };
  };
}
