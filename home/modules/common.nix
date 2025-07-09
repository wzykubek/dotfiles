{ pkgs, ... }: {
	home.packages = with pkgs; [
		fzf
		git
		neovim
		eza
		fd
		ripgrep
		bat
		dust
		nixd
	];

	programs.starship = {
		enable = true;
		settings = {
			add_newline = true;
			nix_shell = {
				disabled = false;
			};
		};
	};

	programs.zsh = {
		enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			sudo = "sudo "; # nie działa
			vim = "nvim";
			tmux = "zellij";
			ls = "eza --hyperlink --git";
			cat = "bat";
			less = "bat --paging=always";
			diff = "diff --color=auto";
			grep = "grep --color=auto";
			ip = "ip -color=auto";
		};

		zplug = {
			enable = true;
			plugins = [
				{ name = "jeffreytse/zsh-vi-mode"; }
			];
		};

		sessionVariables = {
		  EDITOR = "nvim";
		};

		initContent = ''
			alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
			alias -g -- -h='--help 2>&1 | bat --language=help --style=plain'

			source ${pkgs.fzf}/share/fzf/completion.zsh
			source ${pkgs.fzf}/share/fzf/key-bindings.zsh

			eval "$(starship init zsh)"
		'';
	};

	programs.gpg.enable = true;
	services.gpg-agent = {
		enable = true;
		enableSshSupport = true;
		enableZshIntegration = true;
		defaultCacheTtl = 1800;
		maxCacheTtl = 7200;
		pinentry.package = if pkgs.stdenv.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gtk2;
	};

	programs.git = {
		enable = true;
		userName = "Wiktor Zykubek";
		userEmail = "dev@wzykubek.xyz";
		signing = {
			key = "0xE2F941AEA250AFFC";
			signByDefault = true;
		};

		extraConfig = {
			log.abbrevCommit = true;
			init.defaultBranch = "main";
		};
	};

	programs.zellij.enable = true;
	xdg.configFile."zellij/config.kdl".text = ''
		show_startup_tips false
	'';

	programs.bat.enable = true;
	xdg.configFile."bat/config".text = ''
		--italic-text=always
		--style=plain
		--color=always
	'';

	home.stateVersion = "25.05";
}
