{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./users
      ./device
      <home-manager/nixos>
    ];

  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.hyprland.xwayland.enable = true;
  programs.uwsm.enable = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    git-credential-manager
    kitty
    hyprpolkitagent
    dolphin
    kdePackages.qtwayland
    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras
  ];
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    plasma-browser-integration
    oxygen
  ];

  services.openssh.enable = true;
  services.pipewire.enable = true;  
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "127.0.0.1:8384";
    overrideDevices = true;
    overrideFolders = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  # networking.firewall.allowedUDPPorts = [ ... ];

}

