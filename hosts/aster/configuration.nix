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
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  hardware.opentabletdriver.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Autologin from luks password
  boot.initrd.systemd.enable = true;
  systemd.services.display-manager.serviceConfig.KeyringMode = "inherit";
  security.pam.services.sddm-autologin.text = pkgs.lib.mkBefore ''
    auth optional ${pkgs.systemd}/lib/security/pam_systemd_loadkey.so
    auth include sddm
  '';
  services.displayManager.autoLogin.user = "tnu";

  # Plymouth config
  boot.plymouth.enable = true;
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;
  };

  users.groups.ydotool = {};
  users.users.tnu = {
    # uinput and input are for proper kmonad functioning, dialout is for access to serial devices
    extraGroups = [ "wireshark" "uinput" "input" "dialout" "ydotool" ];
  };

  programs.wireshark.enable = true;
  programs.ydotool.enable = true;
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

  services.blueman.enable = true;
  
  services.fprintd.enable = true;
  services.openssh.enable = false;
  
  environment.systemPackages = with pkgs; [
    flatpak-builder
    pavucontrol
  ];

  environment.variables = {
    PBS_REPOSITORY = "aster@pbs@bulb:backup-pool";
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}

