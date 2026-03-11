{ lib, config, ... }:
let
  zswap = config.systemSettings.zswap.enable;
in
{
  options.systemSettings.zswap = {
    enable = lib.mkEnableOption "Enable zswap";
  };

  config = lib.mkIf zswap {
    # Required for zswap lz4 compression
    boot.initrd.systemd.enable = true;

    boot.initrd.kernelModules = [ "lz4" ];

    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1"
    ];
  };
}
