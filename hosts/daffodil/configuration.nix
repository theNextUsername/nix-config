{ ... }:

{
  services.mollysocket.enable = true;
  services.mollysocket = {
    settings.allowed_endpoints = [
      "https://push.services.mozilla.com"
    ];
  };
  system.stateVersion = "25.11";
}
