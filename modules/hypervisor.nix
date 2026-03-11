{
  lib,
  config,
  baseVars,
  ...
}:
let
  hypervisor = config.systemSettings.hypervisor.enable;
in
{
  options.systemSettings.hypervisor = {
    enable = lib.mkEnableOption "Enable Hypervisor Tools";
  };

  config = lib.mkIf hypervisor {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ baseVars.username ];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
  };
}
