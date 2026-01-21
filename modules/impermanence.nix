{
  lib,
  inputs,
  config,
  ...
}:

let
  root = config.fileSystems."/";

  wipeScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)
    (
      mount -t btrfs -o subvol=/ ${root.device} "$MNTPOINT"
      trap 'umount "$MNTPOINT"' EXIT

      echo "Creating needed directories"
      mkdir -p "$MNTPOINT"/persist/var/{log,lib/{nixos,systemd}}
      if [ -e "$MNTPOINT/dont-wipe" ]; then
        echo "Skipping wipe"
      else
        echo "Cleaning root subvolume"
        btrfs subvolume delete -R "$MNTPOINT/root"
        echo "Restoring blank subvolume"
        btrfs subvolume snapshot "$MNTPOINT/root-blank" "$MNTPOINT/root"
      fi
    )
  '';

  # Convert a device path to a systemd .device
  toSystemdDevice =
    device:
    lib.concatStringsSep "-" (
      lib.tail (map (lib.replaceString "-" "\\x2d") (lib.splitString "/" device))
    )
    + ".device";

  phase1Systemd = config.boot.initrd.systemd.enable;
in
{
  boot.initrd = {
    supportedFilesystems = [ "btrfs" ];
    postDeviceCommands = lib.mkIf (!phase1Systemd) (lib.mkBefore wipeScript);
    systemd.services.restore-root = lib.mkIf phase1Systemd {
      description = "Rollback btrfs rootfs";
      wantedBy = [ "initrd.target" ];
      requires = [ (toSystemdDevice root.device) ];
      after = [ (toSystemdDevice root.device) ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = wipeScript;
    };
  };

  imports = [
    inputs.impermanence.nixosModules.impermanence

    (lib.mkAliasOptionModule [ "persist" ] [ "environment" "persistence" "/persist" ])
  ];

  fileSystems."/persist".neededForBoot = true;

  programs.fuse.userAllowOther = true;
  systemd.tmpfiles.rules = [
    "d /persist/home/kevin 0700 kevin users"
  ];

  persist = {
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/bluetooth" # TODO move to bluetooth.nix
    ];

    files = [
      "/etc/machine-id"

      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

  hm.home.persistence."/persist" = {
    directories = [
      "Documents"
      "Downloads"
      "Pictures"
      "Games" # TODO make conditional?
      "src"
      ".ssh"
      ".local/share/keyrings"
      # ".local/share/Steam" # TODO need to figure out how to share HM and system config
    ];
  };
}
