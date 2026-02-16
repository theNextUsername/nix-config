{ ... }:

{
  services.mollysocket.enable = true;
  services.mollysocket = {
    settings.allowed_endpoints = [
      "https://updates.push.services.mozilla.com"
    ];
    environmentFile = "/etc/secrets/mollysocket";
  };
  
  system.stateVersion = "25.11";
}
