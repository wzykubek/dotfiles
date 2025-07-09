{ pkgs, lib, username, ... }: {
  imports = [
    ./modules/common.nix
    ./modules/sway.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.05";
}
