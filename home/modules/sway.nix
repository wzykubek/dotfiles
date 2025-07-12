{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    config = {
      # Some of these bindings are weird, because I'm trying to achieve similar
      # setup on my both machines (Linux and macOS) and unfortunately, I need to
      # do stupind and unlogical workarounds for simple problems. Like this modifier
      # key. On macOS only way to drag, a window on any place to move it is using
      # Ctrl+Cmd (Control+Mod4), and only usable modifier for bindings is on the other
      # hand Option key (Mod1), so sometimes some options are weird.

      modifier = "Mod4"; # Modifier for moving windows arround

      input."*" = {
        repeat_delay = "200"; # Initial delay before repeating key
        repeat_rate = "40"; # Delay each time after initial delay
        natural_scroll = "enabled";
        xkb_layout = "pl";
      };

      keybindings = {
        "Mod1+return" = "exec $TERMINAL";
        "Mod1+space" = "exec rofi -show drun";
        "Mod1+b" = "exec $BROWSER";

        "Mod1+h" = "focus left";
        "Mod1+j" = "focus down";
        "Mod1+k" = "focus up";
        "Mod1+l" = "focus right";
        "Mod1+Shift+h" = "move left";
        "Mod1+Shift+j" = "move down";
        "Mod1+Shift+k" = "move up";
        "Mod1+Shift+l" = "move right";
        "Mod1+f" = "fullscreen";
        "Mod1+Shift+space" = "floating toggle";
        "Mod1+Shift+r" = "reload";
        "Mod1+s" = "layout stacking";
        "Mod1+w" = "layout tabbed";
        "Mod1+e" = "layout toggle split";
        "Mod1+Control+v" = "split vertical";
        "Mod1+Control+h" = "split horizontal";

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

        "Mod4+w" = "kill";
        "Mod4+q" = "kill"; # TODO: Actual killall
      };

      gaps = {
        inner = 5;
        outer = 10;
      };

      window.border = 1;
      window.titlebar = false;

      colors = {
        focused = {
          border = "#83a598"; # blue
          background = "#3c3836";
          text = "#ebdbb2"; # fg
          indicator = "#fabd2f"; # yellow
          childBorder = "#83a598";
        };

        unfocused = {
          border = "#928374"; # gray
          background = "#282828";
          text = "#ebdbb2";
          indicator = "#928374";
          childBorder = "#928374";
        };

        focusedInactive = {
          border = "#504945"; # bg2
          background = "#282828";
          text = "#a89984";
          indicator = "#504945";
          childBorder = "#504945";
        };

        urgent = {
          border = "#fb4934"; # red
          background = "#3c3836";
          text = "#ebdbb2";
          indicator = "#fb4934";
          childBorder = "#fb4934";
        };

        placeholder = {
          border = "#7c6f64";
          background = "#282828";
          text = "#ebdbb2";
          indicator = "#7c6f64";
          childBorder = "#7c6f64";
        };
      };

      output."*" = {
        bg = "~/Pictures/Wallpapers/wallhaven-1q83qg_1920x1080.png fill";
      };
    };

    extraConfig = ''
      blur enable
      blur_xray enable
      corner_radius 20
      shadows enable
      # shadows_on_csd enable
    '';

    checkConfig = false; # Broken with swayfx
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    grim
    slurp
    wl-clipboard
    mako
    rofi-wayland
  ];

  services.mako.enable = true;
}
