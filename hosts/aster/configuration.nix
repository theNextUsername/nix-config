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

  programs.wireshark.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };
  services.fprintd.enable = true;
  services.openssh.enable = false;
  
  environment.systemPackages = with pkgs; [
    flatpak-builder
  ];

  environment.variables = {
    PBS_REPOSITORY = "aster@pbs@pve-cluster04:backup-pool";
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}

