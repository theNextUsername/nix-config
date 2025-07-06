{ pkgs, ...}:
{
  services.displayManager.sddm = {
    enable = true;
    theme = "where_is_my_sddm_theme";
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${./wallpaper.png}";
        backgroundMode = "aspect";
        passwordInputCursorVisible = false;
        showSessionsByDefault = true;
        showUsersByDefault = false;
      };
    })
  ];
}
