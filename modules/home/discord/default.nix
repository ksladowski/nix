{ inputs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord.enable = false; # don't want normal discord client
    vesktop ={
      enable = true;
      settings.arRPC = false;
      state.firstLaunch = false;
    };
    config.plugins = {
      anonymiseFileNames.enable = true;
      ircColors.enable = true;
      replaceGoogleSearch = {
        enable = true;
        customEngineName = "Searx";
        customEngineURL = "https://searx.sladnet.xyz/search?q=";
        replacementEngine = "custom";
      };
      noTypingAnimation.enable = true;
      webKeybinds.enable = true;
      youtubeAdblock.enable = true;
      webScreenShareFixes.enable = true;
      volumeBooster.enable = true;
    };
  };
}
