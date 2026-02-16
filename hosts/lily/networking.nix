{ ... }:

{
  networking.hostName = "lily";
  networking.useDHCP = false;
  networking.firewall.allowedTCPPorts = [ 22 8883 ];
}
