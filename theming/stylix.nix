{ inputs, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    fonts = {
      monospace = {
          name = "JetBrains Mono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
    };
  };
}
