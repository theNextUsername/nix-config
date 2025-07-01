{ pkgs, lib,  config, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.useDHCP = lib.mkDefault true;
  networking.domain = lib.mkDefault "homelab.thenextusername.xyz";
  networking.firewall.enable = true;

  time.timeZone = lib.mkDefault "America/Indiana/Indianapolis";

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
