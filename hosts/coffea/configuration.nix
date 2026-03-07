{ pkgs, config, ... }:
let
    cfg = config.services.forgejo;
    srv = cfg.settings.server;
in {
  services.forgejo.enable = true;
  services.forgejo =   {
    package = pkgs.forgejo;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "coffea.thenextusername.xyz";
        ROOT_URL = "https://${srv.DOMAIN}";
      };
      service.DISABLE_REGISTRATION = true;
      security = {
        GLOBAL_TWO_FACTOR_REQUIREMENT = true;
      };
    };
  };

  homelab.rootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBSFtvSUwl5DKWUzP8yerdiXgCCdgYtUvU4vEV6weA88 tnu@aster"
  ];
}
