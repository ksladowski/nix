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

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:ksladowski/niri-flake";
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

  };

  outputs = { ... } @ inputs:
  {
    nixosConfigurations = {
      ray = inputs.nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/ray ];
        specialArgs = { inherit inputs; };
      };
      rex = inputs.nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/rex ];
        specialArgs = { inherit inputs; };
      };
      testvm = inputs.nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/testvm ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
