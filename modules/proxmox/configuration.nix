{ lib, modulesPath, ... }: {
  
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub.enable = true;
  boot.kernelParams = [
    "console=ttyS0,115200"
  ];

  networking.domain = "homelab.thenextusername.xyz";
  networking.firewall.allowedTCPPorts = [ 22 ];
  
  services.cloud-init = {
    network.enable = true;
    ext4.enable = true;
  };  

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
  
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzZsCPr9p5bdDz1wyhKelr+y8KtqlQDrzK63nWy1wzj tnu@aster"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  }; 
}
