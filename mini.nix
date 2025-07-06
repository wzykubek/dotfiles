{ pkgs, username, ... }: {
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
    brews = [];
    casks = [ "alacritty" "neardrop" "nikitabobko/tab/aerospace" ];
  };

  system.stateVersion = 6;
}
