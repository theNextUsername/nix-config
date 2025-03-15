{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./stylix.nix
    ./sddm.nix
  ];
}
