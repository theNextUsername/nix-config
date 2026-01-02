{ ... }:

{
  imports = [
    ./configuration.nix
  ]; 

  virtualisation.diskSize = 8 * 1024; # 8 GiB
  proxmox = {
    qemuConf = {
      cores = 1;
      memory = 2048;
      name = "nixos";
      agent = true;
      net0 = "virtio=00:00:00:00:00:00,bridge=vmbr1,firewall=1";
    };
    cloudInit = {
      enable = true;
      defaultStorage = "vm-pool";
    };
  };
}
