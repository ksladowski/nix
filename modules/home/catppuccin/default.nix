{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

catppuccin = {
  cursors.enable = true;
  ghostty.enable = true;
  firefox.enable = true;
  fish.enable = true;
  fzf.enable = true;
  fuzzel.enable = true;
  vesktop.enable = true;
  yazi.enable = true;
  nvim.enable = true;
};

}
