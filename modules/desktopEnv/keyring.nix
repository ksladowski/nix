{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.systemSettings.workstation.enable {
    services.gnome.gnome-keyring.enable = true;

    hm.home.packages = with pkgs; [ seahorse ];

    hm-persist = {
      directories = [
        ".local/share/keyrings"
      ];
    };
  };
}
