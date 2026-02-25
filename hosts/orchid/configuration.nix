{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx = {

  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@thenextusername.xyz";
  };
  
  system.stateVersion = "25.11";
}
