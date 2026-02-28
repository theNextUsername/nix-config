{ pkgs, ... }:

{

  services.asterisk.enable = true;
  services.asterisk = {
    confFiles = {
      "extensions.conf" = ''
        [from-internal]
        exten = 100,1,Answer()
        same = n,Wait(1)
        same = n,Playback(hello-world)
        same = n,Hangup()
      '';
      "pjsip.conf" = ''
        [transport-udp]
        type=transport
        protocol=udp
        bind=0.0.0.0

        [6001]
        type=endpoint
        context=from-internal
        disallow=all
        allow=ulaw
        auth=6001
        aors=6001

        [6001]
        type=auth
        auth_type=userpass
        password=unsecurepassword
        username=6001

        [6001]
        type=aor
        max_contacts=1
      '';
    };
    useTheseDefaultConfFiles = [
      "asterisk.conf"
      "modules.conf"
    ];
  };

  homelab.rootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINXgZv7fm5gjd2oguQyFBBqbGLaeoW7HsNUy3S9laqYn tnu@aster"
  ];
}
