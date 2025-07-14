{ username, ... }:
{
  users.users.${username}.home = /Users/${username};
  system.primaryUser = username;

  networking.hostName = "mini";

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = username;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    brews = [ ];
    casks = [
      "alacritty"
      "neardrop"
      "nikitabobko/tab/aerospace"
      "linearmouse"
    ];
  };

  home-manager.users.${username} = {
    imports = [
      ./home/modules/common.nix
      ./home/modules/aerospace.nix
      ./home/modules/linearmouse.nix
    ];

    home.username = username;
    home.homeDirectory = /Users/${username};

    programs.alacritty.settings.font.size = 18;

    home.stateVersion = "25.05";
  };

  system.stateVersion = 6;
}
