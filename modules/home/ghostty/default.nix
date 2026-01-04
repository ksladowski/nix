{ inputs, ... }:
{

  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = 0.8;
      window-padding-x = 4;
      window-padding-y = 4;
      window-padding-balance = true;
    };
    enableFishIntegration = true;
  };
}
