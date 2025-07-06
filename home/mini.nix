{ pkgs, username, ... }: {
  imports = [
    ./modules/common.nix
    ./modules/aerospace.nix
  ];

  home.username = username;
  home.homeDirectory = /Users/${username};
}
