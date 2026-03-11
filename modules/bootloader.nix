{ lib, config, ... }:
let
  bootloader = config.systemSettings.bootloader.enable;
in
{
  options.systemSettings.bootloader = {
    enable = lib.mkEnableOption "Enable bootloader (systemd-boot)";
  };

  config = lib.mkIf bootloader {

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
