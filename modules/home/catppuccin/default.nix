{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

catppuccin = {
  cursors.enable = true;
  ghostty.enable = true;
  firefox ={
  enable = true;
  profiles.default = {
    enable = true;
    force = true;
  };
  };
  fish.enable = true;
  fzf.enable = true;
  vesktop.enable = true;
  yazi.enable = true;
};

}
