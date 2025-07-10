{ pkgs, lib, username, ... }: {
  imports = [ ./hardware-configuration.nix ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "latitude";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus-16";
    keyMap = lib.mkForce "pl";
    useXkbConfig = true;
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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.pulseaudio.enable = false;

  programs.xwayland.enable = true;
  services.libinput.enable = true;
  services.printing = {
		enable = true;
		browsing = true;
	};
	services.avahi = {
	  enable = true;
		nssmdns = true;
	};
	services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel" ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  home-manager.users.${username} = {
    imports = [
      ./home/modules/common.nix
      ./home/modules/sway.nix
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.packages = with pkgs; [ google-chrome pantheon.elementary-files ];
    home.sessionVariables.BROWSER = "google-chrome-stable --ozone-platform=wayland";

    gtk = {
      enable = true;

      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
    };
    home.sessionVariables.GTK_THEME = "Adwaita-dark";

    home.stateVersion = "25.05";
  };

  system.stateVersion = "25.05";
}
