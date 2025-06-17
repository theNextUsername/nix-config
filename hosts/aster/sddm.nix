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
      theme = "maya";
      wayland.enable = true;
      extraPackages = with pkgs.kdePackages; [
        breeze
        breeze-icons
      ];
      package = pkgs.kdePackages.sddm;
    };
    environment.systemPackages = [
      (
        pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf" ''
           [General]
           background = ${background-package}
        ''
      
      )
    ];
  }
