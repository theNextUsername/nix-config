{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    unison
  ];

  homelab.rootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/CaNWRZR9TH3EIMU3lvN7IdBVps909rO4keGd7zTrT tnu@aster"
  ];
}
