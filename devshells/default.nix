{
  perSystem =
    { config, pkgs, ... }:
    {

      imports = [
        ./dotnet.nix
      ];

      devshells.default = {
        packages = with pkgs; [
          nixd
          nixfmt
        ];
      };
    };
}
