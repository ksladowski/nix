{
  inputs,
  config,
  lib,
  ...
}:
{

  options.systemSettings.pterodactyl-wing = {
    enable = lib.mkEnableOption "Enable pterodactyl wing";
  };

  imports = [
    inputs.pterodactyl.nixosModules.default
    { nixpkgs.overlays = [ inputs.pterodactyl.overlays.default ]; }
  ];

  config = lib.mkIf config.systemSettings.pterodactyl-wing.enable {
    services.pterodactyl.wings = {
      enable = true;
      openFirewall = true;
      uuid = "your-node-uuid";
      remote = "https://panel.example.com";
      tokenIdFile = "/path/to/token/id";
      tokenFile = "/path/to/token";
      api.ssl.enable = false;
    };

    virtualisation.docker.enable = true;
  };
}
