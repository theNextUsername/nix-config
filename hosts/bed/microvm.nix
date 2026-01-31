{ self, ... }:

{
  
  microvm.autostart = [
    "daffodil"
    "peony"
  ];

  microvm.vms = {
    daffodil = {
      flake = self;
      updateFlake = "github:/theNextUsername/nix-config";
    };
    peony = {
      flake = self;
      updateFlake = "github:/theNextUsername/nix-config";
    };
  };
}
