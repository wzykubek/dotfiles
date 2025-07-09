{ pkgs, ... }:
{
	home.file.".config/aerospace/aerospace.toml".source = builtins.toString ./aerospace.toml;
}
