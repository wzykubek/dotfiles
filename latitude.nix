{ config, pkgs, lib, username, ... }: {
  imports = [ ./hardware-configuration.nix ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "latitude";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus-16";
    keyMap = lib.mkForce "pl";
    useXkbConfig = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.pulseaudio.enable = false;
  
  programs.xwayland.enable = true;
  services.libinput.enable = true;
  services.printing.enable = true;
  services.gnome.gnome-keyring.enable = true;
  
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel" ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  system.stateVersion = "25.05";
}
