{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
    let
      system = "x86_64-linux";

      nixpkgs-patched =
        (import inputs.nixpkgs { inherit system; }).applyPatches {
          name = "nixpkgs-patched";
          src = inputs.nixpkgs;
          patches = [];
        };

      pkgs = import nixpkgs-patched {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      lib = inputs.nixpkgs.lib;

      hosts = builtins.filter (x: x != null) (lib.mapAttrsToList (name: value: if (value == "directory") then name else null) (builtins.readDir ./hosts));

    in {
      nixosConfigurations = builtins.listToAttrs
        (map (host: {
          name = host;
          value = lib.nixosSystem {
            inherit system;
            modules = [
              # host specific config
              { config.networking.hostName = host; }
              (./hosts + "/${host}")
              #  (inputs.secrets.hostSecrets.${host})
              inputs.disko.nixosModules.disko
              inputs.home-manager.nixosModules.home-manager
              inputs.stylix.nixosModules.stylix

              # ./modules/system
            ];
          };
        }) hosts);
      homeConfigurations = {
        "kevin" = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [./home.nix];
        };
      };
    };
}
