{ ... }: {
  imports = [
    ./configuration.nix
    ./networking.nix
    ./niri.nix
    ./stylix.nix
    ./sddm.nix
    ./syncthing.nix
  ];
}
