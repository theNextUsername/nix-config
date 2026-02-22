{ ... }:

{
  networking.hostName = "nepenthes";
  networking.firewall.allowedTCPPorts = [ 22 3000 9090 ];
}
