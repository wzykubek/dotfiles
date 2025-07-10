{ pkgs, username, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ neovim gnupg curl zellij ];

  programs.zsh.enable = true;

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
}
