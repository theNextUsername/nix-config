{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  proxmoxLXC.manageNetwork = true;
  networking.useDHCP = true;
  networking.hostName = "tritoma";

  environment.systemPackages = with pkgs; [
    helix
  ];

  services.sshd.enable = true;
  system.stateVersion = "25.05";
}
