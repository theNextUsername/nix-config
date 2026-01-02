{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    unison
  ];

  users.users.root.openssh.authorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/CaNWRZR9TH3EIMU3lvN7IdBVps909rO4keGd7zTrT tnu@aster"
  ];

}
