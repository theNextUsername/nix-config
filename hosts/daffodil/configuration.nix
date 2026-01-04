{ ... }:

{
  services.mollysocket.enable = true;
  services.mollysocket = {
    settings.allowed_endpoints = [
      "https://push.services.mozilla.com"
    ];
  };

  systemd.services.mollysocket = {
    serviceConfig = {
      LoadCredentialEncrypted = "vapid.key:/etc/mollysocket/private/vapid.key";
      Environment = "MOLLY_VAPID_KEY_FILE=%d/vapid.key";
    };
  };
  
  system.stateVersion = "25.11";
}
