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
      "sip"  
    ];
    networking.firewall.extraCommands = ''
        iptables -A INPUT -m conntrack --ctstate RELATED -m helper --helper sip -d 192.168.2.60 -p udp -j ACCEPT 
    '';
    networking.firewall.extraStopCommands = ''
        iptables -D INPUT -m conntrack --ctstate RELATED -m helper --helper sip -d 192.168.2.60 -p udp -j ACCEPT 
    '';
    networking.extraHosts = ''
        192.168.2.18 owntracks.thenextusername.xyz
    '';
}
