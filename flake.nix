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
  in {
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
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          imports = [
            (import ./modules/common.nix { inherit pkgs username; })
            (import ./latitude.nix { inherit pkgs username; })
          ];
        })
        {
          imports = [ home-manager.nixosModules.home-manager ];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = false;
            backupFileExtension = "bak";
            users.${username} = { pkgs, ... }: import ./home/latitude.nix { inherit pkgs username; };
          };
        }
      ];
    };
  };
}
