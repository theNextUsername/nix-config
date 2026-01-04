{ ... }:

{
  services.mollysocket.enable = true;
  services.mollysocket = {
    settings.allowed_endpoints = [
      "https://updates.push.services.mozilla.com"
    ];
    environmentFile = "/etc/mollysocket/private/environment";
  };
  
  system.stateVersion = "25.11";
}
