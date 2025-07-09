{ pkgs, username, ... }: {
  imports = [
    ./modules/common.nix
    ./modules/aerospace/default.nix
    ./modules/linearmouse/default.nix
  ];

  home.username = username;
  home.homeDirectory = /Users/${username};
}
