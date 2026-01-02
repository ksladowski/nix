{ inputs, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/espresso.yaml";
    fonts = {
      monospace = {
          name = "JetBrains Mono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
    };
  };
}
