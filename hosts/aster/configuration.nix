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
    extraGroups = [ "wireshark" "uinput" "input" ];
  };

  programs.wireshark.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;
    };
  };
  
  services.fprintd.enable = true;
  services.openssh.enable = false;
  
  environment.systemPackages = with pkgs; [
    flatpak-builder
  ];

  environment.variables = {
    PBS_REPOSITORY = "aster@pbs@bulb:backup-pool";
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}

