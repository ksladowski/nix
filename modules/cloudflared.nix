{
  config,
  lib,
  pkgs,
  ...
}:
{

  options.systemSettings.cloudflared = {
    enable = lib.mkEnableOption "Enable cloudflare tunnel";
  };

  config = lib.mkIf config.systemSettings.cloudflared.enable {

    sops.secrets."cloudflared/tunnel-id" = {
      owner = "cloudflared";
      group = "cloudflared";
      mode = "0440";
    };
    sops.secrets."cloudflared/token" = {
      owner = "cloudflared";
      group = "cloudflared";
      mode = "0440";
    };

    users.users.cloudflared = {
      group = "cloudflared";
      isSystemUser = true;
    };
    users.groups.cloudflared = { };

    systemd.services.cloudflared-tunnel = {
      wantedBy = [ "multi-user.target" ];
      after = [
        "network-online.target"
        "systemd-resolved.service"
      ];
      serviceConfig = {
        ExecStart = "${pkgs.writeShellScript "cloudflared-tunnel" ''
          ${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run \
          --token="$(cat ${config.sops.secrets."cloudflared/token".path})" \
          "$(cat ${config.sops.secrets."cloudflared/tunnel-id".path})";
        ''}";
        Restart = "always";
        User = "cloudflared";
        Group = "cloudflared";
      };
    };
  };
}
