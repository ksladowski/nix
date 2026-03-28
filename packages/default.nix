{
  inputs,
  self,
  lib,
  ...
}:
{
  perSystem =
    {
      pkgs,
      inputs',
      system,
      ...
    }:
    {
      _module.args.pkgs = import self.inputs.nixpkgs {
        inherit system;
        inherit
          ((import ../system/nix/nixpkgs.nix {
            inherit
              inputs
              self
              lib
              pkgs
              ;
          }).nixpkgs
          )
          overlays
          config
          ;
      };
      packages = {
        roslyn-with-razor = pkgs.callPackage ./roslyn-with-razor {
          ms-dotnettools = pkgs.vscode-extensions.ms-dotnettools.csharp;
        };
      };
    };
}
