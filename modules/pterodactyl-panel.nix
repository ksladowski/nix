{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{

  options.systemSettings.pterodactyl-panel = {
    enable = lib.mkEnableOption "Enable pterodactyl game server manager";
  };

  imports = [
    inputs.pterodactyl.nixosModules.default
    { nixpkgs.overlays = [ inputs.pterodactyl.overlays.default ]; }
  ];

  config = lib.mkIf config.systemSettings.pterodactyl-panel.enable {
    services.caddy = {
      enable = true;
      package = pkgs.frankenphp.override {
        php = config.services.pterodactyl.panel.phpPackage;
      };
      virtualHosts = {
        "pterodactyl.sladnet.xyz".extraConfig = ''
          root * ${config.services.pterodactyl.panel.package}/public
          php_server
        '';
      };
    };

    services.pterodactyl.panel = {
      enable = true;
      enableNginx = false;
      user = "caddy";
      group = "caddy";
      database.user = "caddy";
      app.url = "https://pterodactyl.sladnet.xyz";
    };

    users.users.caddy.extraGroups = [ "redis" ];
  };
}
