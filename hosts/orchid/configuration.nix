{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx = {
    virtualHosts."www.addisyn.me" = {
      root = "/var/www/html";      
    };
    virtualHosts."addisyn.me" = {
      root = "/var/www/html";
    };
  };
  
  system.stateVersion = "25.11";
}
