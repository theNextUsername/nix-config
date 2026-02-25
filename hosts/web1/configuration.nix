{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx = {
    virtualHosts."www.addisyn.me" = {
      # enableACME = true;
      # forceSSL = true;
      root = "/var/www/html";      
    };
    virtualHosts."addisyn.me" = {
      # enableACME = true;
      # forceSSL = true;
      root = "/var/www/html";
    };
  };

  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "acme@thenextusername.xyz";
  # };
  
  system.stateVersion = "25.11";
}
