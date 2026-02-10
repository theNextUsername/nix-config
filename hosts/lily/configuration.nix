{ pkgs, config, ... }:
let
  sslCertDir = config.security.acme.certs."lily.thenextusername.xyz".directory;
in
{

  services.mosquitto.enable = true;
  services.mosquitto.listeners = [
    {
      port = 8883;
      settings = {
        keyfile = "${sslCertDir}/key.pem";
        certfile = "${sslCertDir}/fullchain.pem";
      };
      users = {
        "root" = {
          hashedPasswordFile = "/etc/secrets/root_passwd";
          acl = [
            "readwrite #"
          ];
        };
        "93f8" = {
          hashedPasswordFile = "/etc/secrets/93f8_passwd";
          acl = [
            "readwrite msh/#"
          ];
        };
      };
    }
  ];
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@thenextusername.xyz";
    certs = {
      "lily.thenextusername.xyz" = {
        domain = "lily.thenextusername.xyz";
        group = "mosquitto";
        dnsProvider = "cloudflare";
        environmentFile = "/etc/secrets/cloudflare";
        reloadServices = [
          "mosquitto"
        ];
      };
    };
  };

  homelab.rootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfWEdt4E7jNmFxkIKUM4EE82J0wc5LgroSmJsvq6dnf tnu@aster"
  ];
}
