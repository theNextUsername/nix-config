# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, lib, config, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    "ciscoPacketTracer8"
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  hardware.opentabletdriver.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.tnu = {
    extraGroups = [ "wireshark" ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
  };
  programs.wireshark.enable = true;
  programs.nm-applet.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
  
  services.udisks2.enable = true;

  # Automatically enabled by niri
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  # enable auto-unlock of kwallet taken from the plasma.nix module in nixpkgs
  security.pam.services = {
    swaylock = {};
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

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.fprintd.enable = true;
  services.flatpak.enable = true;
  services.sshd.enable = false;
  
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
    flatpak-builder
    thunderbird
    proxmox-backup-client
    ciscoPacketTracer8
    wl-clipboard-rs
    xwayland-satellite
    ssh-to-age
    proxmox-backup-client
  ];

  environment.variables = {
    PBS_REPOSITORY = "aster@pbs@pve-cluster04:backup-pool";
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}

