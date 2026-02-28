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
        exten = 100,1,Answer()
        same = n,Wait(1)
        same = n,Playback(hello-world)
        same = n,Hangup()
      '';
      "pjsip.conf" = ''
        [transport-udp]
        type=transport
        protocol=udp
        bind=0.0.0.0:5060

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
      "modules.conf"
    ];
  };

  homelab.rootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINXgZv7fm5gjd2oguQyFBBqbGLaeoW7HsNUy3S9laqYn tnu@aster"
  ];
}
