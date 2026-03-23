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

    pelican.url = "github:Hythera/nix-pelican";

    catppuccin.url = "github:catppuccin/nix";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-ld.url = "github:Mic92/nix-ld";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    devshell.url = "github:numtide/devshell";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;

      systems = [
        "x86_64-linux"
      ];

      imports = [
        inputs.devshell.flakeModule
        ./packages
        ./devshells
      ];

      flake =
        let
          lib = inputs.nixpkgs.lib;

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
            raven = lib.nixosSystem {
              specialArgs = specialArgs // {
                hostVars = {
                  hostname = "raven";
                  stateVersion = "25.05";
                };
              };
              modules = recursiveImport [
                ./modules
                ./hosts/raven
              ];
            };
          };
        };
    };
}
