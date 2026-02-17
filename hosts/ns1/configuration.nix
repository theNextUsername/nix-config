{ pkgs, ... }:
{
  system.autoUpgrade = {
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };

  environment.systemPackages = with pkgs; [
    bind
  ];
  
  services.bind.enable = true;
  services.bind = {
    zones = {
      "812914.xyz" = {
        master = false;
        masters = [
          "192.168.2.53"
        ];
        ## Cannot currently set masters and slaves concurrently
        # slaves = [
        #   "204.87.183.53"          # NS-Global
        #   "2607:7c80:54:6::53"     # NS-Global
        #   "69.65.50.192"           # FreeDNS
        #   "2001:1850:1:5:800::6b"  # FreeDNS
        # ];
        extraConfig = ''
          allow-transfer {
            204.87.183.53;
            2607:7c80:54:6::53;
            69.65.50.192;
            2001:1850:1:5:800::6b;
          };
          also-notify {
            204.87.183.53;
            2607:7c80:54:6::53;
          };
        '';
        file = "/var/lib/bind/db.812914.xyz";
      };
    };
  };
  
  system.stateVersion = "25.11";
}
