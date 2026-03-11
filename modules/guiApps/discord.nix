{
  inputs,
  lib,
  config,
  ...
}:
let
  discord = config.systemSettings.discord.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  options.systemSettings.discord = {
    enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf discord {
    hm = lib.mkIf homeManager {
      imports = [
        inputs.nixcord.homeModules.nixcord
      ];

      programs.nixcord = {
        enable = true;
        discord.enable = false; # don't want normal discord client
        vesktop = {
          enable = true;
          settings.arRPC = false;
          state.firstLaunch = false;
        };
        config.plugins = {
          anonymiseFileNames.enable = true;
          ircColors.enable = true;
          replaceGoogleSearch = {
            enable = true;
            customEngineName = "Kagi";
            customEngineURL = "https://kagi.com/search?q=";
            replacementEngine = "custom";
          };
          noTypingAnimation.enable = true;
          webKeybinds.enable = true;
          youtubeAdblock.enable = true;
          webScreenShareFixes.enable = true;
          volumeBooster.enable = true;
        };
      };
    };

    hm-persist = lib.mkIf impermanence {
      directories = [
        ".config/vesktop"
      ];
    };
  };
}
