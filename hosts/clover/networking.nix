{ lib, ... }:

{
  networking.hostName = "clover";
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 5060 ];
  networking.firewall.connectionTrackingModules = [
    "sip"
  ];
  networking.firewall.extraCommands = ''
      iptables -A INPUT -m conntrack --cstate RELATED -m helper --helper sip -d 192.168.2.60 -p udp -j ACCEPT 
  '';
  networking.firewall.extraStopCommands = ''
      iptables -D INPUT -m conntrack --cstate RELATED -m helper --helper sip -d 192.168.2.60 -p udp -j ACCEPT 
  '';
}
