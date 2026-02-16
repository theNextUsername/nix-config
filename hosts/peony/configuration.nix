{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bind
  ];
  
  services.bind.enable = true;
  services.bind = {
    extraConfig = ''
      include "/etc/bind/peony-lily.key";
    '';
    zones = {
      "812914.xyz" = {
        master = true;
        slaves = [
          "192.168.2.5"
        ];
        file = "/var/lib/bind/db.812914.xyz";
        extraConfig = ''
          dnssec-policy default;
          notify explicit;
          also-notify {
            192.168.2.5;
          };
          update-policy {
            grant peony-lily. name 3fe2e04af520a31703bc1db72714cd61f27a0945cd6d5144273de388f4edf34.acme.812914.xyz. TXT;
          };
        '';
      };
    };
  };
  
  system.stateVersion = "25.11";
}
