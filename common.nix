{ pkgs, lib,  config, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.useDHCP = lib.mkDefault true;
  networking.domain = lib.mkDefault "homelab.thenextusername.xyz";
  networking.firewall.enable = lib.mkDefault true;

  time.timeZone = "America/Indiana/Indianapolis";

  environment.systemPackages = with pkgs; [
    helix
    git
  ];

  services.sshd.enable = lib.mkDefault true;

  users.users.tnu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
