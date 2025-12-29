{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7691b83c-1015-452d-98c0-3563474aa11f";
      fsType = "ext4";
    };

  boot.initrd.luks.devices = {
    "luks-f027b384-de44-4608-ac5a-e3d3a05fc51c".device = "/dev/disk/by-uuid/f027b384-de44-4608-ac5a-e3d3a05fc51c";
    "luks-240648cb-9fcb-4cfd-a59e-e5fd101d0224".device = "/dev/disk/by-uuid/240648cb-9fcb-4cfd-a59e-e5fd101d0224";
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3B74-21D6";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/d21e2f3a-924b-40bb-8e94-187469e0f8fb"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
