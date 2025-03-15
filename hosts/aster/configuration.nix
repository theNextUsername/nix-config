{ config, ... }:
{
  hardware.opentabletdriver.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "aster";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Indiana/Indianapolis";

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.libinput.enable = true;

  #Might want to move this somewhere better?
  users.users.tnu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "tnu" ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    gitFull
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [  ];
}
