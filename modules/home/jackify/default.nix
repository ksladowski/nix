{ inputs, pkgs, ... }:
{

  home.packages = with pkgs; [
          inputs.jackify.packages.${pkgs.system}.default
  ];
}
