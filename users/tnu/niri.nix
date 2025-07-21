{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
      swayidle
      swaybg
      brightnessctl
      playerctl
      libnotify
      xwayland-satellite
    ];
    systemd.user.services.swaybg = {
      Unit = {
        Description = "Set window manager background";
        PartOf = "graphical-session.target";
        After = "graphical-session.target niri.service";
        Requisite = "graphical-session.target";
      };
      
      Install= {
        WantedBy = [ "niri.service" ];
      };
      
      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.stylix.image}";
      };
    };
    services.mako = {
      enable = true;
      settings = {
        default-timeout = 3000;
      };
    };
    services.swayidle = {
      enable = true;
      timeouts = [
        { timeout = 600; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
        { timeout = 601; command = "${pkgs.niri}/bin/niri msg action power-off-monitors"; }
      ];
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      ];
    };
    programs.swaylock.enable = true;
    programs.fuzzel.enable = true;
    programs.niri = {
        settings = {
          overview.backdrop-color = config.lib.stylix.colors.base00;
          hotkey-overlay.skip-at-startup = true;
          environment = {
            NIXOS_OZONE_WL = "1";
            DISPLAY = ":0";
            QT_QPA_PLATFORM = "wayland";
          };
          spawn-at-startup = [
            { command = [ "xwayland-satellite" ]; }
            { command = [ "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init" ]; }
          ];
          input = {
            keyboard.xkb = {
              layout = "us";
              options = "compose:rctrl";
            };
          };
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
          prefer-no-csd = true;
          outputs."DP-1" = {
            position = {
              x = 1920;
              y = 130;
            };
          };
          outputs."HDMI-A-1" = {
            position = {
              x = 0;
              y = 0;
            };
          };
          window-rules = [
            {
              matches = [
                { is-active = false; }
              ];
              opacity = 0.75;
              draw-border-with-background = false;
            }
          ];
          binds = with config.lib.niri.actions; {
            "Mod+Shift+Slash".action = show-hotkey-overlay;
            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action.spawn = [
                "wpctl"
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "0.1+"
              ];
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action.spawn = [
                "wpctl"
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "0.1-"
              ];
            };
            "XF86AudioMute" = {
              allow-when-locked = true;
              action.spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SINK@"
                "toggle"
              ];
            };
            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action.spawn = [
                "brightnessctl"
                "s"
                "10%+"
              ];
            };
            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action.spawn = [
                "brightnessctl"
                "s"
                "10%-"
              ];
            };
            "XF86AudioPause" = {
              allow-when-locked = true;
              action.spawn = [
                "playerctl"
                "play-pause"
              ];
            };
            "XF86AudioPlay" = {
              allow-when-locked = true;
              action.spawn = [
                "playerctl"
                "play-pause"
              ];
            };
            "XF86AudioPrev" = {
              allow-when-locked = true;
              action.spawn = [
                "playerctl"
                "previous"
              ];
            };
            "XF86AudioNext" = {
              allow-when-locked = true;
              action.spawn = [
                "playerctl"
                "next"
              ];
            };
            "Mod+Q" = {
              repeat = false;
              action = close-window;
            };
            "Mod+O" = {
              repeat = false;
              action = toggle-overview;
            };
            "Mod+Left".action = focus-column-left;
            "Mod+Down".action = focus-window-down;
            "Mod+Up".action = focus-window-up;
            "Mod+Right".action = focus-column-right;
            "Mod+Ctrl+Left".action = move-column-left;
            "Mod+Ctrl+Down".action = move-window-down;
            "Mod+Ctrl+Up".action = move-window-up;
            "Mod+Ctrl+Right".action = move-column-right;
            "Mod+Home".action = focus-column-first;
            "Mod+End".action = focus-column-last;
            "Mod+Ctrl+Home".action = move-column-to-first;
            "Mod+Ctrl+End".action = move-column-to-last;
            "Mod+Shift+Left".action = focus-monitor-left;
            "Mod+Shift+Down".action = focus-monitor-down;
            "Mod+Shift+Up".action = focus-monitor-up;
            "Mod+Shift+Right".action = focus-monitor-right;
            "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
            "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
            "Mod+Page_Down".action = focus-workspace-down;
            "Mod+Page_Up".action = focus-workspace-up;
            "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
            "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
            "Mod+WheelScrollRight".action = focus-column-right; 
            "Mod+WheelScrollLeft".action = focus-column-left; 
            "Mod+Ctrl+WheelScrollRight".action =  move-column-right; 
            "Mod+Ctrl+WheelScrollLeft".action =  move-column-left; 
            "Mod+Shift+WheelScrollDown".action = focus-column-right; 
            "Mod+Shift+WheelScrollUp".action = focus-column-left; 
            "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right; 
            "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left; 
            "Mod+1".action.focus-workspace = 1; 
            "Mod+2".action.focus-workspace = 2; 
            "Mod+3".action.focus-workspace = 3; 
            "Mod+4".action.focus-workspace = 4; 
            "Mod+5".action.focus-workspace = 5; 
            "Mod+6".action.focus-workspace = 6; 
            "Mod+7".action.focus-workspace = 7; 
            "Mod+8".action.focus-workspace = 8; 
            "Mod+9".action.focus-workspace = 9; 
            "Mod+Ctrl+1".action.move-column-to-workspace = 1; 
            "Mod+Ctrl+2".action.move-column-to-workspace = 2; 
            "Mod+Ctrl+3".action.move-column-to-workspace = 3; 
            "Mod+Ctrl+4".action.move-column-to-workspace = 4; 
            "Mod+Ctrl+5".action.move-column-to-workspace = 5; 
            "Mod+Ctrl+6".action.move-column-to-workspace = 6; 
            "Mod+Ctrl+7".action.move-column-to-workspace = 7; 
            "Mod+Ctrl+8".action.move-column-to-workspace = 8; 
            "Mod+Ctrl+9".action.move-column-to-workspace = 9; 
            "Mod+BracketLeft".action = consume-or-expel-window-left; 
            "Mod+BracketRight".action = consume-or-expel-window-right; 
            "Mod+Comma".action = consume-window-into-column; 
            "Mod+Period".action = expel-window-from-column; 
            "Mod+R".action = switch-preset-column-width; 
            "Mod+Shift+R".action = switch-preset-window-height; 
            "Mod+Ctrl+R".action = reset-window-height; 
            "Mod+F".action = maximize-column; 
            "Mod+Shift+F".action = fullscreen-window; 
            "Mod+Ctrl+F".action = expand-column-to-available-width; 
            "Mod+C".action = center-column; 
            "Mod+Minus".action.set-column-width = "-10%"; 
            "Mod+Equal".action.set-column-width = "+10%"; 
            "Mod+Shift+Minus".action.set-window-height = "-10%"; 
            "Mod+Shift+Equal".action.set-window-height = "+10%"; 
            "Mod+V".action = toggle-window-floating; 
            "Mod+Shift+V".action = switch-focus-between-floating-and-tiling; 
            "Mod+W".action = toggle-column-tabbed-display; 
            "Mod+Escape" = {
                allow-inhibiting = false;
                action = toggle-keyboard-shortcuts-inhibit;
            }; 
            "Mod+Shift+E".action = quit; 
            "Ctrl+Alt+Delete".action = quit; 
            "Mod+Shift+P".action = power-off-monitors;
            "Mod+Shift+S".action = screenshot; 
            "Mod+L".action.spawn = "swaylock";
            "Mod+B".action.spawn = "librewolf";              
            "Mod+T".action.spawn = "alacritty";
            "Alt+Space".action.spawn = "fuzzel";
          };
        };
      };
}
