{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "mpt3sas" "nvme" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "vm-pool/subvol-113-disk-0";
      fsType = "zfs";
    };

  fileSystems."/home/tnu" =
    { device = "storage-pool/subvol-113-disk-0";
      fsType = "zfs";
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
