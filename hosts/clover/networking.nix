{ lib, ... }:

{
  networking.hostName = "clover";
  networking.firewall.enable = lib.mkForce false;
  # networking.firewall.allowedTCPPorts = [ 22 ];
}
