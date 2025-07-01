{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];


  proxmoxLXC.manageNetwork = true;
  networking.hostName = "blossom";

  system.stateVersion = "25.05";
}
