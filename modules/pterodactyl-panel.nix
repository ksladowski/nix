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

    sops.secrets."pterodactyl/key" = { };
    sops.secrets."pterodactyl/database" = { };
    sops.secrets."pterodactyl/salt" = { };
    sops.secrets."pterodactyl/redis" = { };

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
      database.passwordFile = config.sops.secrets."pterodactyl/database".path;
      redis.passwordFile = config.sops.secrets."pterodactyl/redis".path;
      hashids.saltFile = config.sops.secrets."pterodactyl/salt".path;
      # mail.passwordFile = config.sops.secrets."pterodactyl/".path;
      app = {
        url = "https://pterodactyl.sladnet.xyz";
        keyFile = config.sops.secrets."pterodactyl/key".path;
      };
    };

    users.users.caddy.extraGroups = [ "redis" ];
  };
}
