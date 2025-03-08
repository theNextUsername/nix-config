{ config, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./stylix.nix
  ];
}
