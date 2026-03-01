{ pkgs, config, ... }:

{

  services.asterisk.enable = true;
  services.asterisk = {
    confFiles = let
      apkg = config.services.asterisk.package;
    in {
      "asterisk.conf" = ''
        [directories]
        astcachedir => /var/cache/asterisk
        astetcdir => /etc/asterisk
        astmoddir => ${apkg}/lib/asterisk/modules
        astvarlibdir => /var/lib/asterisk
        astdbdir => /var/lib/asterisk
        astkeydir => /var/lib/asterisk
        astdatadir => /var/lib/asterisk
        astagidir => ${apkg}/var/lib/asterisk/agi-bin
        astspooldir => /var/spool/asterisk
        astrundir => /var/run/asterisk
        astlogdir => /var/log/asterisk
        astsbindir => ${apkg}/sbin
      '';
      "extensions.conf" = ''
        [from-internal]
        exten = 6001,1,Dial(PJSIP/6001,20)
        exten = 6002,1,Dial(PJSIP/6002,20)
        exten = 100,1,Answer()
        same = n,Wait(1)
        same = n,Playback(hello-world)
        same = n,Wait(50)
        same = n,Hangup()
      '';
      "pjsip.conf" = ''
        [transport-udp]
        type=transport
        protocol=udp
        bind=0.0.0.0:5060

        [endpoint_internal](!)
        type=endpoint
        context=from-internal
        disallow=all
        allow=ulaw

        [6001](endpoint_internal)
        auth=6001
        aors=6001

        [6002](endpoint_internal)
        auth=6002
        aors=6002

        [auth_userpass](!)
        type=auth
        auth_type=userpass

        [6001](auth_userpass)
        password=unsecurepassword
        username=6001

        [6002](auth_userpass)
        password=alsounsecure
        username=6002

        [aor_dynamic](!)
        type=aor
        max_contacts=1

        [6001](aor_dynamic)
        [6002](aor_dynamic)
      '';
    };
    useTheseDefaultConfFiles = [
      "modules.conf"
    ];
  };

  homelab.rootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINXgZv7fm5gjd2oguQyFBBqbGLaeoW7HsNUy3S9laqYn tnu@aster"
  ];
}
