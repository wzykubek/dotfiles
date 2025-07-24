{
  description = "Unified setup for NixOS and macOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      nix-darwin,
      home-manager,
      nix-homebrew,
      nixvim,
      ...
    }:
    let
      username = "wzykubek";
    in
    {
      darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager

          ./modules/common/desktop/configuration.nix
          ./mini/configuration.nix
        ];

        specialArgs = {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          inherit username nixvim;
        };
      };

      nixosConfigurations."latitude" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          home-manager.nixosModules.home-manager

          ./modules/common/desktop/configuration.nix
          ./latitude/configuration.nix

        ];

        specialArgs = {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          inherit username nixvim;
        };
      };

      nixosConfigurations."hetzner" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hetzner/configuration.nix
          disko.nixosModules.disko
        ];
      };
    };
}
