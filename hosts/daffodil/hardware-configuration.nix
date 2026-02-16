{ lib, config, ... }: {
  microvm = {
    hypervisor = "qemu";

    shares = [
      {
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        proto = "virtiofs";
      }
      {
        tag = "secrets";
        source = "/etc/secrets/${config.networking.hostName}";
        mountPoint = "/etc/secrets";
        proto = "virtiofs";
      }
    ];
    
    interfaces = [
      {
        type = "tap";
        id = "vm-nic1";
        mac = "02:00:00:00:00:01";
      }
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
