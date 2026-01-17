{ ... }:

{
  nixpkgs.config.allowUnfree = true;  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "finbar";
  
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
  };

  system.autoUpgrade = {
    upgrade = false;
    runGarbageCollection = true;
    persistent = true;
    operation = "boot";
    dates = "daily";
    flake = "/etc/nixos/flake.nix";
  };

  system.stateVersion = "25.11"; 
}
