{ ... }:

{
  networking.hostName = "peony";

  systemd.network.enable = true;
  systemd.network.networks = {
    "20-lan" = {
      matchConfig.Type = "ether";
      networkConfig = {
        Address = ["192.168.2.53/24"];
        Gateway = "192.168.2.2";
        DNS = ["192.168.2.4"];
        DHCP = "no";
        IPv6AcceptRA = true;
      };
    };

    "50-wg0" = {
      matchConfig.Name = "wg0";
      address = [
        "10.0.0.53/24"
        "2607:f1c0:f028:d000::5/126"
      ];
      routingPolicyRules = [
        {
          User = "named";
          Family = "both";
          InvertRule = true;
          Table = 1000;
          Priority = 3000;
        }
      ];
    };
  };
  systemd.network.netdevs = {
    "50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };
      wireguardConfig = {
        ListenPort = 51820;
        PrivateKeyFile = "/etc/secrets/wireguard.key";
      };
      wireguardPeers = [
        {
          PublicKey = "tuvnaq8G2CEpQgCo+np4vrNaxU1vbKY4q9hekPVX+zc=";
          AllowedIPs = [
            "0.0.0.0/0"
            "::/0"             
          ];
          Endpoint = "74.208.184.180:51820";
          PersistentKeepalive = 25;
          RouteTable = 1000;
        }
      ];
    };
    
  };
}
