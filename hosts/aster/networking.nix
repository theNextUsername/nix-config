{ ... }:
{
    networking.hostName = "aster";
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "dnsmasq";

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    networking.firewall.allowedTCPPorts = [  ];
    networking.firewall.allowedUDPPorts = [ 51820 ];
}
