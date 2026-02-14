{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  systemSettings = {

    bluetooth.enable = true;
    amd.enable = true;

    # Gaming
    steam.enable = true;
    # jackify.enable = true;
    sunshine.enable = true;

    wine.enable = true;
    hypervisor.enable = true;

    super-slicer.enable = true;

    nextcloud.enable = true;

  };
}
