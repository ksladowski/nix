{ inputs, pkgs, ... }:
{

  home.packages = [
    inputs.jackify.packages.${pkgs.system}.default
  ];
}
