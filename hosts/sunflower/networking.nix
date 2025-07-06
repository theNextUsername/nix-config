{ ... }:
{
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "dnsmasq";

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
    networking.firewall.allowedUDPPorts = [ ];
}
