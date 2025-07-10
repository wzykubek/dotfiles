{ pkgs, username, nixvim, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ 
		neovim gnupg curl zellij 
	];

  programs.zsh.enable = true;

  environment.shellAliases = {
    vim = "nvim";
  };

	fonts = {
	  enableDefaultPackages = true;
		packages = with pkgs; [
			nerd-fonts.iosevka
		];

		fontconfig = {
		  defaultFonts = {
			  monospace = [ "Iosevka Nerd Font Mono" ];
			};
		};
	};

  users.users = {
    "${username}" = {
      shell = pkgs.zsh;
    };
    "root" = {
      shell = pkgs.zsh;
    };
  };

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = false;
		sharedModules = [
			nixvim.homeManagerModules.nixvim
		];
		backupFileExtension = "bak";
	};
}
