{ pkgs, username, ... }: {
  imports = [
    ./modules/common.nix
    ./modules/sway.nix
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
}
