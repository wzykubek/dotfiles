{ pkgs, username, ... }: {
  imports = [
    ./modules/common.nix
  ];

  home.username = username;
  home.homeDirectory = /home/${username};
}
