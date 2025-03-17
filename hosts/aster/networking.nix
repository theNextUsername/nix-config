{ ... }:
{
    networking.hostName = "aster";
    networking.search = [ "homelab.thenextusername.xyz" ];
    networking.nameservers = [ "192.168.2.4" ];
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "dnsmasq";

    networking.firewall.allowedTCPPorts = [  ];
    networking.firewall.allowedUDPPorts = [ 51820 ];
}
