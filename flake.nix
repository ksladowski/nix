{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      lib = nixpkgs.lib // home-manager.lib; # this appends the contents, preferring the contents of HM if there's a conflict

      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

    in {

      inherit lib;

      nixosConfigurations = {
        vivobook = lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./hosts/vivobook
            inputs.disko.nixosModules.disko
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };
    };
}
