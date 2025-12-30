{ pkgs, ... }:

{
  imports = [
    ./networking.nix
    ./hardware-configuration.nix
  ];
  
  environment.systemPackages = with pkgs; [
    unison
  ];

  system.stateVersion = "25.11";
}
