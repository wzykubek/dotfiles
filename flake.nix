{
  description = "Unified NixOS + nix-darwin + Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nix-darwin, home-manager, nix-homebrew, nixvim, ... }:
  let
    username = "wzykubek";
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager

        ./modules/common.nix
        ./mini.nix

				{ 
					home-manager.users.${username} = { pkgs, lib, ... }: import ./home/latitude.nix { inherit pkgs lib username; }; 
				}
      ];
      
			specialArgs = {
        inherit pkgs username nixvim;
      };
    };

    nixosConfigurations."latitude" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        home-manager.nixosModules.home-manager

        ./modules/common.nix
        ./latitude.nix

				{ 
					home-manager.users.${username} = { pkgs, lib, ... }: import ./home/latitude.nix { inherit pkgs lib username; }; 
				}

      ];

      specialArgs = {
        inherit pkgs username nixvim;
      };
    };
  };
}
