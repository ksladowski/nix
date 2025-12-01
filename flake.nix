{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, ... }:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      lib = inputs.nixpkgs.lib;

    in {
      nixosConfigurations = {
        nixos-vm = lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/nixos-vm/configuration.nix
            #  (inputs.secrets.hostSecrets.${host})
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kevin = ./home.nix;
            }
          ];
        };
      };
    };
}
