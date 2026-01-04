{ ... }: {
  microvm = {
    hypervisor = "cloud-hypervisor";

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
