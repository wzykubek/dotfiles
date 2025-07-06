{ pkgs, username, ... }: {
  networking.hostName = "latitude";

  users.users.${username} = {
    isNormalUser = true;
    home = /home/${username};
    extraGroups = [ "wheel" ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
}
