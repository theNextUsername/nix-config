# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
  #programs.hyprland.enable = true;
  #programs.hyprland.withUWSM = true;
  #programs.hyprland.xwayland.enable = true;
  #programs.uwsm.enable = true;

  hardware.opentabletdriver.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Indiana/Indianapolis";

  users.users.tnu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "wireshark" ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
  };
  programs.wireshark.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.libinput.enable = true;
  services.fprintd.enable = true;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    vim
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
  ];

  environment.variables = {
    PBS_REPOSITORY = "aster@pbs@pve-cluster04:backup-pool";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

