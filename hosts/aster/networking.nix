{ ... }:
{
    networking.hostName = "aster";
    networking.networkmanager.enable = true;

    networking.firewall.allowedTCPPorts = [  ];
    networking.firewall.allowedUDPPorts = [ 51820 ];

    networking.nameservers = [ "192.168.2.4" "1.1.1.1" ];

    networking.wireguard.interfaces = {
        wg0 = {
            ips = [ "10.0.0.20/24" ];
            listenPort = 51820;
            privateKeyFile = "/home/tnu/.wireguard/private";

            peers = [
                {
                    publicKey = "tuvnaq8G2CEpQgCo+np4vrNaxU1vbKY4q9hekPVX+zc=";
                    allowedIPs = [ "10.0.0.0/24" "192.168.2.0/24" ];
                    endpoint = "debian-ozone.thenextusername.xyz:51820";
                    persistentKeepalive = 25;
                }
            ];
        };
    };
}
