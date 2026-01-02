{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];
  
  system.stateVersion = "25.11";
}
