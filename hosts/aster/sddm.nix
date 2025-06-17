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
    theme = "where_is_my_sddm_theme";
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${background-package}";
        backgroundMode = "none";
      };
    })
  ];
}
