{ pkgs, lib, username, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      input."*" = {
	repeat_delay = "200";
	repeat_rate = "40";
	natural_scroll = "enabled";
      };
      keybindings = {
        "Mod1+return"      = "exec alacritty";
        "Mod1+space"       = "exec rofi -show drun";
        
        "Mod1+h"           = "focus left";
        "Mod1+j"           = "focus down";
        "Mod1+k"           = "focus up";
        "Mod1+l"           = "focus right";
        "Mod1+Shift+h"     = "move left";
        "Mod1+Shift+j"     = "move down";
        "Mod1+Shift+k"     = "move up";
        "Mod1+Shift+l"     = "move right";
        "Mod1+f"           = "fullscreen";
        "Mod1+Shift+space" = "floating toggle";
        "Mod1+Shift+r"     = "reload";
        "Mod1+s"           = "layout stacking";
        "Mod1+w"           = "layout tabbed";
        "Mod1+e"           = "layout toggle split";
        "Mod1+Control+v"   = "split vertical";
        "Mod1+Control+h"   = "split horizontal";
        
        # TODO: Add smart resizing script
        # "Mod1+minus"       = "";
        # "Mod1+equal"       = "";
        
        "Mod1+1" = "workspace number 1";
        "Mod1+2" = "workspace number 2";
        "Mod1+3" = "workspace number 3";
        "Mod1+4" = "workspace number 4";
        "Mod1+5" = "workspace number 5";
        "Mod1+6" = "workspace number 6";
        "Mod1+7" = "workspace number 7";
        "Mod1+8" = "workspace number 8";
        "Mod1+9" = "workspace number 9";
        "Mod1+0" = "workspace number 10";
        "Mod1+Shift+1" = "move container to workspace number 1";
        "Mod1+Shift+2" = "move container to workspace number 2";
        "Mod1+Shift+3" = "move container to workspace number 3";
        "Mod1+Shift+4" = "move container to workspace number 4";
        "Mod1+Shift+5" = "move container to workspace number 5";
        "Mod1+Shift+6" = "move container to workspace number 6";
        "Mod1+Shift+7" = "move container to workspace number 7";
        "Mod1+Shift+8" = "move container to workspace number 8";
        "Mod1+Shift+9" = "move container to workspace number 9";
        "Mod1+Shift+0" = "move container to workspace number 10";

        "Mod4+q" = "kill";
      };
    };
  };

  home.packages = with pkgs; [
    swaylock swayidle grim slurp wl-clipboard
    mako alacritty rofi-wayland
  ];

  services.mako.enable = true;

  # home.stateVersion = "25.05";
}
