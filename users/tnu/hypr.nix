{ ... }:
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1.333";
    "$terminal" = "kitty";
    "$browser" = "firefox";
    "$mod" = "SUPER";
    exec-once = [
      "systemctl --user enable --now hyprpolkitagent.service"
      "systemctl --user enable --now hyprpaper.service"
      "kwalletd6&"
    ];
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];
    general = {
      gaps_in = 1;
      gaps_out = 2;
      border_size = 1;
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };
    decoration = {
      rounding = 0;
      active_opacity = "1.0";
      inactive_opacity = "0.7";
      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
      };
      blur = {
        enabled = false;
      };
    };
    animations = {
      enabled = false;
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
    master = {
      new_status = "master";
    };
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
    };
    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0;
      touchpad = {
        natural_scroll = true;
      };
    };
    gestures = {
      workspace_swipe = false;
    };
    bind = [
      "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, $fileManager"
        "$mod, V, togglefloating,"
        "$mod, R, exec, $menu"
        "$mod, F, exec, $browser"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
    ] ++ (
        builtins.concatLists (builtins.genList
          (i:
           let ws = i + 1;
           in [
           "$mod, code:1${toString i}, workspace, ${toString ws}"
           "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
           ]
          )
          9
          )
        );
    bindm = [
      "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
    ];
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
    ];
    windowrulev2 = [
      "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
}
