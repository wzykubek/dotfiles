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
  in {
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager

        ./modules/common.nix
        ./mini.nix
      ];

      specialArgs = {
        pkgs = import nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
        inherit username nixvim;
      };
    };

    nixosConfigurations."latitude" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager

        ./modules/common.nix
        ./latitude.nix


      ];

      specialArgs = {
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
        inherit username nixvim;
      };
    };
  };
}
