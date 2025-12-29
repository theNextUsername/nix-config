{ pkgs, lib,  config, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.nixos-cli.enable = true;

  networking.useDHCP = lib.mkDefault true;
  networking.domain = lib.mkDefault "homelab.thenextusername.xyz";
  networking.firewall.enable = true;

  # Configure split DNS
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";

  environment.etc."NetworkManager/dnsmasq.d/servers".text = ''
    server=/homelab.thenextusername.xyz/192.168.2.4 
  '';
  

  time.timeZone = lib.mkDefault "America/Indiana/Indianapolis";

  environment.systemPackages = with pkgs; [
    helix
    git
  ];

  services.openssh.enable = lib.mkDefault true;

  users.users.tnu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
