{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-240648cb-9fcb-4cfd-a59e-e5fd101d0224".device = "/dev/disk/by-uuid/240648cb-9fcb-4cfd-a59e-e5fd101d0224";
  networking.hostName = "sunflower";

  system.stateVersion = "25.05"; # Did you read the comment?
}
