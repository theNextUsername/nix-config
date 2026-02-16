{ ... }:

{
  networking.hostName = "peony";
  networking.useDHCP = false;
  networking.firewall.allowedTCPPorts = [ 22 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
