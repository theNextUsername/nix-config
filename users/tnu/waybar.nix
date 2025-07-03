{ pkgs, ... }:

{
  programs.waybar.package = pkgs.waybar.overrideAttrs (prevAttrs: {
    patches = [
      (pkgs.fetchpatch {
        url = "https://github.com/Alexays/Waybar/pull/4234.patch";
        hash = "sha256-RRGy/aeFX95fW0pT6mXhww2RdEtoOnaT3+dc7iB3bAY=";
      })
    ];
  });
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
