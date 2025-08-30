{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        clock = {
          timezone = "America/New_York";
          tooltip-format = "{:%Y-%m-%d}";
        };
        battery = {
          format = "{icon}";
          format-icons = ["" "" "" "" ""];
          tooltip-format = "{capacity}% {timeTo}";
          format-charging = "󱐋{icon}";
        };
        pulseaudio = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = ["󰕿" "󰖀" "󰕾"];
          tooltip-format = "{volume}%";
        };
        backlight = {
          format = "{icon}";
          format-icons = ["󰃞" "󰃟" "󰃠"];
          tooltip-format = "{percent}%";
        };
        "custom/power" = {
          format = " 󰐥 ";
          on-double-click = "systemctl poweroff";
        };
        layer = "top";
        height = 30;
        modules-right = [
          "backlight"
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];
        modules-left = [
          "custom/power"
        ];
      };
    };
  };
}
