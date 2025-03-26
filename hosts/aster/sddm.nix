{ pkgs, ...}: let
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ./.;
    dontUnpack = true;
    installPhase = ''
      cp $src/wallpaper.png $out
    '';
  };
 in {
    services.displayManager.sddm = {
      enable = true;
      theme = "breeze";
      wayland.enable = true;
    };
    environment.systemPackages = [
      (
        pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
           [General]
           background = ${background-package}
        ''
      
      )
    ];
  }
