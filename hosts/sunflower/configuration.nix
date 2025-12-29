{ config, lib, pkgs, ... }:

{
  imports = [
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
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Autologin from luks password
  boot.initrd.systemd.enable = true;
  systemd.services.display-manager.serviceConfig.KeyringMode = "inherit";
  security.pam.services.sddm-autologin.text = pkgs.lib.mkBefore ''
    auth optional ${pkgs.systemd}/lib/security/pam_systemd_loadkey.so
    auth include sddm
  '';
  services.displayManager.autoLogin.user = "tnu";
 
  networking.hostName = "sunflower";

  users.users.tnu = {
    extraGroups = [ "wireshark" "uinput" "input" ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
