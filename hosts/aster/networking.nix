{ pkgs, lib, ... }:
{
    networking.hostName = "aster";
    networking.networkmanager.enable = true;
   
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # kdeconnect
    ];
    networking.firewall.allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # kdeconnect
    ];
    networking.firewall.allowedTCPPorts = [  ];
    networking.firewall.allowedUDPPorts = [ 51820 ];
    networking.firewall.connectionTrackingModules = [
      "tftp"  
    ];
    networking.firewall.extraCommands = ''
        iptables -A PREROUTING -t raw -j CT -p udp --dport 69 --helper tftp
    '';
    networking.firewall.extraStopCommands = ''
        iptables -D PREROUTING -t raw -j CT -p udp --dport 69 --helper tftp
    '';
    networking.extraHosts = ''
        192.168.2.18 owntracks.thenextusername.xyz
    '';
}
