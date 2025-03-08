{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "{pkgs.base16-schemes}/share/themes/darcula.yaml";
    image = ./wallpaper.png;
  };
}
