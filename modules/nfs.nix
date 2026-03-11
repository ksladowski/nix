{
  lib,
  config,
  ...
}:
let
  nfsClient = config.systemSettings.nfsClient.enable;
in
{
  options.systemSettings.nfsClient = {
    enable = lib.mkEnableOption "Enable nfs mount for NAS";
  };

  config = lib.mkIf nfsClient {
    boot.supportedFilesystems = [ "nfs" ];
    fileSystems."/mnt/media" = {
      device = "truenas.lan:/mnt/tank0/media";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };
  };
}
