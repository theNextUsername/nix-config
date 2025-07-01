{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  networking.hostName = "tritoma";

  system.stateVersion = "25.05";
}
