{ pkgs, username, ... }: {
  imports = [
    ./modules/common.nix
    ./modules/aerospace.nix
    ./modules/linearmouse/default.nix
  ];

  home.username = username;
  home.homeDirectory = /Users/${username};
}
