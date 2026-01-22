{
  lib,
  config,
  baseVars,
  ...
}:
let
  cfg = config.systemSettings.hypervisor;
in
{
  options.systemSettings.hypervisor = {
    enable = lib.mkEnableOption "Enable Hypervisor Tools";
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ baseVars.username ];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
  };
}
