{ ... }:

{
  networking.hostName = "orchid";
  networking.useDHCP = false;
  networking.firewall.allowedTCPPorts = [ 22 80 ];
}
