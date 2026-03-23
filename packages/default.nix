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
      packages = rec {
        ms-dotnettools = pkgs.callPackage ./ms-dotnettools.csharp { };
        csharp-tools = pkgs.callPackage ./csharp-tools { inherit ms-dotnettools; };
      };
    };
}
