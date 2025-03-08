{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/qualia.yaml";
    image = ./wallpaper.png;
    homeManagerIntegration.followSystem = true;
  };
}
