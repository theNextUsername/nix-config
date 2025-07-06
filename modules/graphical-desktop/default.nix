{ pkgs, lib, config, ... }:

{
  imports = [
    ./sddm.nix
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
  };
  programs.nm-applet.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
 
  # enable auto-unlock of kwallet taken from the plasma.nix module in nixpkgs
  security.pam.services = {
    swaylock = {}; # Allow swaylock to be enabled in home manager
    login.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };
    kde = {
      allowNullPassword = false;
      kwallet = {
        enable = true;
        package = pkgs.kdePackages.kwallet-pam;
      };
    };
    kde-fingerprint = lib.mkIf config.services.fprintd.enable { fprintAuth = true; };
    kde-smartcard = lib.mkIf config.security.pam.p11.enable { p11Auth = true; };
  };

  # Automatically enabled by niri, disabled to use kwallet instead
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  services.udisks2.enable = true;
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;
  services.flatpak.enable = true;
  
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
    wget
    gitFull
    nil
    bash-language-server
    wireguard-tools
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US
    thunderbird
    wl-clipboard-rs
    xwayland-satellite
    ssh-to-age
    proxmox-backup-client
  ];
}

