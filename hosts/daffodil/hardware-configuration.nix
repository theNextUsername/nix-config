{ config, ... }: {
  microvm = {
    hypervisor = "cloud-hypervisor";

    volumes = [
      {
        label = "secrets";
        readOnly = true;
        size = 10;
        mountPoint = "/etc/mollysocket/private";
        image = "/var/lib/microvms/${config.networking.hostName}/secrets.img";
      }
    ];
    
    shares = [
      {
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
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
}
