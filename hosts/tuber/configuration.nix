{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    unison
  ];

  users.users = {
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/CaNWRZR9TH3EIMU3lvN7IdBVps909rO4keGd7zTrT tnu@aster"
    ];
    tnu.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBx7Q4gxioqzh7MlZ3JKHGGrOokqWkM20aHzSX2qjGnS tnu@aster"   
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFL0KSsHKHrz+Qp4pcNgBes0Vzv1lCmJ4ZztuqItMB/ tnu@sunflower"
    ];
  };
}
