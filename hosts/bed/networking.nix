{ ... }:

{
  networking.useDHCP = false;
  
  systemd.network.enable = true;

  systemd.network.networks."10-lan" = {
    matchConfig.Name = [ "enp0s31f6" "vm-*" ];
    networkConfig = {
      Bridge = "br0";
    };
  };

  systemd.network.netdevs."br0" = {
    netdevConfig = {
      Name = "br0";
      Kind = "bridge";
    };
  };

  systemd.network.networks."10-lan-bridge" = {
    matchConfig.Name = "br0";
    networkConfig = {
      IPv6AcceptRA = true;
      DHCP = "yes";
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
