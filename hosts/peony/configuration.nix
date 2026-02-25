{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bind
  ];
  
  services.bind.enable = true;
  services.bind = {
    extraOptions = ''
      key-directory "/etc/bind";
    '';
    extraConfig = ''
      include "/etc/bind/peony-lily.key";
      include "/etc/bind/peony-patch.key";
      include "/etc/bind/peony-web1.key";
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
            grant peony-lily. name _acme-challenge.3fe2e04af520a31703bc1db72714cd61f27a0945cd6d5144273de388f4edf34.812914.xyz. TXT;
            grant peony-patch. name _acme-challenge.24297fd6f177d0d97e40c2a4ba822bc3a76a7442cdf1300b1524483b68b7e52.812914.xyz. TXT;
            grant peony-web1. name _acme-challenge.7b103805de4ac1976fc60c25df6ebda0cfce3076da15adce94f2f8c4e2b8256.812914.xyz. TXT;
            grant peony-web1. name _acme-challenge.50f7dae05d132bb733fe0b8f0e2afd93bdaf02109fe3416f3ff6ba397743080.812914.xyz. TXT;
          };
        '';
      };
    };
  };
  
  system.stateVersion = "25.11";
}
