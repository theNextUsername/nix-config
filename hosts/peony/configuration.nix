{ ... }:
{
  services.bind.enable = true;
  # services.bind = {
  #   zones = {
  #     "812914.xyz" = {
  #       master = true;
  #       file = ./db.812914.xyz.zone;
  #     };
  #   };
  # };
  
  system.stateVersion = "25.11";
}
