{ pkgs, lib, ... }:

{

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/darcula.yaml";
    image = pkgs.runCommand "wallpaper.png" { } ''
      ${lib.getExe pkgs.imagemagick} ${./wallpaper.png} -modulate 100,10,110 $out
    '';
    polarity = "dark";
    homeManagerIntegration.followSystem = true;
  };

}
