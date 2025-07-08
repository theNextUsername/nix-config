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
        layer = "top";
        height = 30;
        modules-right = [
          "backlight"
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];
      };
    };
  };
}
