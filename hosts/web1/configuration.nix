{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx = {
    virtualHosts."www.addisyn.me" = {
      useACMEHost = "addisyn.me";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://orchid.homelab.thenextusername.xyz";
      };
    };
    virtualHosts."addisyn.me" = {
      useACMEHost = "addisyn.me";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://orchid.homelab.thenextusername.xyz";
      };
    };
    virtualHosts."coffea.thenextusername.xyz" = {
      useACMEHost = "coffea.thenextusername.xyz";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://coffea.homelab.thenextusername.xyz:3000";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@thenextusername.xyz";
    certs = {
      "addisyn.me" = {
        domain = "addisyn.me";
        extraDomainNames = [
          "www.addisyn.me"
        ];
        group = "nginx";
        dnsProvider = "rfc2136";
        environmentFile = pkgs.writeText "rfc2136-environment" ''
          RFC2136_NAMESERVER=peony.homelab.thenextusername.xyz
          RFC2136_TSIG_KEY=peony-web1.
          RFC2136_TSIG_FILE=/etc/secrets/peony-web1.key
        '';
      };
      "coffea.thenextusername.xyz" = {
        domain = "coffea.thenextusername.xyz";
        group = "nginx";
        dnsProvider = "rfc2136";
        environmentFile = pkgs.writeText "rfc2136-environment" ''
          RFC2136_NAMESERVER=peony.homelab.thenextusername.xyz
          RFC2136_TSIG_KEY=peony-web1.
          RFC2136_TSIG_FILE=/etc/secrets/peony-web1.key
        '';
      };
    };
  };
  
  system.stateVersion = "25.11";
}
