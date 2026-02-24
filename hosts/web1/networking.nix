{ ... }:

{
  networking.hostName = "web1";
  networking.useDHCP = false;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [
        "10.0.0.6/24"
        "2607:f1c0:f028:d000::6/126"
      ];
      dns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      privateKeyFile = "/etc/wireguard/private.key";
      peers = [
        {
          publicKey = "tuvnaq8G2CEpQgCo+np4vrNaxU1vbKY4q9hekPVX+zc=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          persistentKeepalive = 10;
          endpoint = "ozone.thenextusername.xyz:51820";
        }
      ];
    };
  };
}
