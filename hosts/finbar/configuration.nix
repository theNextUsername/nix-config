{ ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  
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
