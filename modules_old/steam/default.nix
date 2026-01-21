{ ... }:

let
  base =
    { config, lib, ... }:
    {
      options.features = {
        steam = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Steam";
        };
      };
    };

  homeModule =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home = lib.mkIf config.features.steam {

        home.persistence."/persist".directories = lib.mkAfter [
          ".local/share/Steam"
        ];
      };

      meta = {
        description = "Home-manager conf for steam (not useful standalone)";
      };
    };

  nixosModule =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = lib.mkIf config.features.steam [ homeModule ];

      config = lib.mkIf config.features.steam {
        programs.steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };

        programs.gamescope = {
          enable = true;
          capSysNice = true;
        };
      };

      meta = {
        description = "Steam";
      };
    };
in
{
  inherit base homeModule nixosModule;
}
