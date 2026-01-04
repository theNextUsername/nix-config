{ self, ... }:

{
  
  microvm.autostart = [
    "daffodil"
  ];

  microvm.vms = {
    daffodil = {
      flake = self;
      updateFlake = "github:/theNextUsername/nix-config";
    };
  };
}
