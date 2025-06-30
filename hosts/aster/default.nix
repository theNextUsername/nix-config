{ ... }: {
  imports = [
    ./configuration.nix
    ./networking.nix
    ./stylix.nix
    ./sddm.nix
    ./syncthing.nix
    ./sops.nix
  ];
}
