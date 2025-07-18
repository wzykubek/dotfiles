{ pkgs, ... }:
{
  imports = [ ./nixvim.nix ];

  home.packages = with pkgs; [
    fzf
    git
    eza
    fd
    ripgrep
    bat
    dust
    nixd
    nixfmt-rfc-style

    zed-editor
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
    enableCompletion = false; # Fix startup speeds
    syntaxHighlighting.enable = true;

    shellAliases = {
      sudo = "sudo ";
      tmux = "zellij";
      ls = "eza --hyperlink --git --icons=auto";
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
        { name = "Aloxaf/fzf-tab"; }
      ];
    };

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];

    initContent = ''
      			alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
      			alias -g -- -h='--help 2>&1 | bat --language=help --style=plain'

            zstyle ':completion:*' menu no
            zstyle ':completion:*:descriptions' format '[%d]'
            zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      		'';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.alacritty = {
    enable = true;
    theme = "gruvbox_dark";
    settings = {
      font = {
        normal.family = "Iosevka Nerd Font Mono";
      };
      window = {
        padding.x = 10;
        padding.y = 10;
        opacity = 0.85;
        blur = true;
      };
    };
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
