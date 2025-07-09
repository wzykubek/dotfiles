{
  description = "Unified NixOS + nix-darwin + Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nix-homebrew, ... }:
  let
    username = "wzykubek";
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home/latitude.nix
      ];

      extraSpecialArgs = {
        inherit pkgs username;
      };
    };

    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        ({ pkgs, ... }: {
          imports = [
            (import ./modules/common.nix { inherit pkgs username; })
            (import ./mini.nix { inherit pkgs username; })
          ];
        })
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = false;
            backupFileExtension = "bak";
            users.${username} = { pkgs, ... }: import ./home/mini.nix { inherit pkgs username; };
          };
        }
      ];
    };

    nixosConfigurations."latitude" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        home-manager.nixosModules.home-manager
        ./modules/common.nix
        ./latitude.nix

        ({ config, pkgs, ...}: {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = false;
            backupFileExtension = "bak";
            users.${username} = { pkgs, lib, ... }: import ./home/latitude.nix { inherit pkgs lib username; };
          };
        })
      ];

      specialArgs = {
        inherit pkgs username;
      };
    };
  };
}
