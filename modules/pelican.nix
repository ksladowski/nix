# Initial setup -> sudo -u pelican-panel pelican-cli p:user:make
{
  inputs,
  config,
  lib,
  ...
}:
let
  pelican = config.systemSettings.pelican.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{

  options.systemSettings.pelican = {
    enable = lib.mkEnableOption "Enable pelican game server manager";
  };

  imports = [
    inputs.pelican.nixosModules.default
    { nixpkgs.overlays = [ inputs.pelican.overlays.default ]; }
  ];

  config = lib.mkIf pelican {

    sops.secrets."pelican/key" = {
      owner = "pelican-panel";
      mode = "0440";
    };
    sops.secrets."pelican/database" = {
      owner = "pelican-panel";
      mode = "0440";
    };
    sops.secrets."pelican/redis" = {
      owner = "pelican-panel";
      mode = "0440";
    };
    sops.secrets."smtp-app-pass" = {
      owner = "pelican-panel";
      mode = "0440";
    };
    sops.secrets."pelican/wing/token-id" = {
      owner = "pelican-wings";
      mode = "0440";
    };
    sops.secrets."pelican/wing/token" = {
      owner = "pelican-wings";
      mode = "0440";
    };

    services.pelican.panel = {
      enable = true;
      app = {
        url = "https://pelican.sladnet.xyz";
        keyFile = config.sops.secrets."pelican/key".path;
      };
      database.passwordFile = config.sops.secrets."pelican/database".path;
      redis.passwordFile = config.sops.secrets."pelican/redis".path;
      mail = {
        host = "smtp.mailbox.org";
        port = 465;
        username = "ksladowski@mailbox.org";
        fromAddress = "pelican@sladnet.xyz";
        passwordFile = config.sops.secrets."smtp-app-pass".path;
      };
    };

    services.pelican.wings = {
      enable = true;
      openFirewall = true;
      uuid = "cfa7d2b1-e2a0-4949-a3f2-3b57e6c78f81";
      remote = "https://pelican.sladnet.xyz";
      tokenIdFile = config.sops.secrets."pelican/wing/token-id".path;
      tokenFile = config.sops.secrets."pelican/wing/token".path;
      api.ssl.enable = false;
    };

    virtualisation.docker.enable = true;

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };

    persist = lib.mkIf impermanence {
      directories = [
        "/var/lib/docker"
        "/var/lib/mysql"
        "/var/lib/pelican"
        "/var/lib/pelican-panel"
        "/var/lib/pelican-wings"
        "/var/lib/redis-pelican-panel"
      ];
    };
  };
}
