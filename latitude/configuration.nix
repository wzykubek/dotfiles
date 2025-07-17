{
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [ ./hardware.nix ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "latitude";
  systemd.services.ModemManager.enable = true;
  networking.networkmanager = {
    enable = true;

    ensureProfiles.profiles = {
      Cellural = {
        connection = {
          id = "Orange";
          uuid = "533c7844-f8a1-42e6-ae45-90b993119453";
          type = "gsm";
          interface-name = "cdc-wdm0";
        };
        gsm = {
          apn = "internetipv6";
          username = "internet";
          password = "internet";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "default";
          method = "auto";
        };
      };
    };
  };

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = lib.mkForce "pl";
    useXkbConfig = true;
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font Mono" ];
      };
    };
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
  services.printing = {
    enable = true;
    browsing = true;
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  security.polkit.enable = true;
  security.pam.services = {
    swaylock = { };
    # https://support.yubico.com/hc/en-us/articles/360016649099-Ubuntu-Linux-login-guide-U2F
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      START_CHARGE_THRESH_BAT0 = 40;
      # STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  home-manager.users.${username} = {
    imports = [
      ./../home/modules/common.nix
      ./../home/modules/sway.nix
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.packages = with pkgs; [
      pantheon.elementary-files
      google-chrome
    ];
    home.sessionVariables.BROWSER = "google-chrome-stable --ozone-platform=wayland";

    gtk = {
      enable = true;

      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
    };
    home.sessionVariables.GTK_THEME = "Adwaita-dark";

    programs.alacritty.settings.font.size = 16;

    home.stateVersion = "25.05";
  };

  system.stateVersion = "25.05";
}
