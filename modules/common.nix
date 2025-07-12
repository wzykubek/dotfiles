{
  pkgs,
  username,
  nixvim,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    neovim
    gnupg
    curl
    zellij
  ];

  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false; # Fix startup times

  environment.shellAliases = {
    vim = "nvim";
  };

  users.users = {
    "${username}" = {
      shell = pkgs.zsh;
    };
    "root" = {
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    sharedModules = [
      nixvim.homeManagerModules.nixvim
    ];
    backupFileExtension = "bak";
  };
}
