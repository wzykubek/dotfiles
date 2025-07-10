{ pkgs, ... }:
{
  home.file.".config/aerospace/aerospace.toml".source = ../configs/aerospace.toml;
}
