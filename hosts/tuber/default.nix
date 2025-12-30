{ pkgs, ... }:

{
  modules = [
    ./networking.nix
  ];
  
  environment.systemPackages = with pkgs; [
    unison
  ];
}
