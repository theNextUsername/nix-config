{ lib, modulesPath, ... }: {
  
  imports = [
    # need to look into what this module does
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.autoUpgrade = {
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };

  nix.gc.options = "--delete-old";


  # Will not be able to rebuild if the grub device is not set
  # for a regular BIOS build we can just specify the block device
  # that should be booted from
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  # This lets us use xterm.js from the proxmox web interface
  boot.kernelParams = [
    "console=ttyS0,115200"
  ];

  networking.domain = "homelab.thenextusername.xyz";
  networking.firewall.allowedTCPPorts = [ 22 ];
  
  # I thought this was included in the qemu-guest.nix file above,
  # but it seems like it is not, as the guest agent dies after rebuilding
  services.qemuGuest.enable = true;

  networking.useDHCP = false; # Network is handled by cloud-init
  # Should probably look at what other options are available for this
  services.cloud-init = {
    enable = true;
    network.enable = true;
    ext4.enable = true;
  };

  users.users.root = {
    # Have to use mkDefault here so it can be overridden in each host
    openssh.authorizedKeys.keys = lib.mkDefault [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzZsCPr9p5bdDz1wyhKelr+y8KtqlQDrzK63nWy1wzj tnu@aster"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      # Only allow public key authentication
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  }; 
}
