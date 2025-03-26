{ ... }:
{
    networking.hostName = "aster";
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "dnsmasq";

    networking.firewall.allowedTCPPorts = [  ];
    networking.firewall.allowedUDPPorts = [ 51820 ];
}
