{ config, pkgs, ... }:

{
  # Required for zswap lz4 compression
  boot.initrd.systemd.enable = true;

  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=lz4"
    "zswap.max_pool_percent=20"
    "zswap.shrinker_enabled=1"
  ];
}