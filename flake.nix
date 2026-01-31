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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    catppuccin.url = "github:catppuccin/nix";

    jackify = {
      url = "github:keygenesis/jackify";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;

      supportedSystems = [ "x86_64-linux" ];

      forAllSystems =
        apply: lib.genAttrs supportedSystems (system: apply inputs.nixpkgs.legacyPackages.${system});

      recursiveImport = import ./recursiveImport.nix { inherit lib; };

      specialArgs = {
        inherit inputs;
        baseVars = {
          username = "kevin";
          homeDirectory = "/home/kevin";
        };
      };
    in
    {
      devShells = forAllSystems (
        pkgs:
        let
          files = recursiveImport [ ./devShells ];

          makeAttr =
            p:
            let
              fname = builtins.baseNameOf p;
              len = builtins.stringLength fname;
              hasNix = len > 4 && builtins.substring (len - 4) 4 fname == ".nix";
              name = if hasNix then builtins.substring 0 (len - 4) fname else fname;
            in
            {
              name = name;
              value = import p { inherit pkgs; };
            };
        in
        builtins.listToAttrs (map makeAttr files)
      );

      nixosConfigurations = {
        ray = lib.nixosSystem {
          specialArgs = specialArgs // {
            hostVars = {
              hostname = "ray";
              stateVersion = "25.05";
            };
          };
          modules = recursiveImport [
            ./modules
            ./hosts/ray
          ];
        };
        rex = lib.nixosSystem {
          specialArgs = specialArgs // {
            hostVars = {
              hostname = "rex";
              stateVersion = "25.05";
            };
          };
          modules = recursiveImport [
            ./modules
            ./hosts/rex
          ];
        };
      };
    };
}
