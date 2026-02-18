{ pkgs, config, ... }:
# let
#   hostName = config.networking.hostName;
# in
{
  services.prometheus.enable = true;
  services.prometheus = {
    stateDir = "prometheus2";
    globalConfig.scrape_interval = "10s";
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = [
            "localhost:${toString config.services.prometheus.exporters.node.port}"
          ];
        }];
      }
    ];

    exporters.node = {
      enable = true;
      port = 9000;
      enabledCollectors = [
        "ethtool"   
        "softirqs"
        "systemd"
        "tcpstat"
        "wifi"
      ];
    };
  };

  # services.opentelemetry-collector.enable = true;
  # services.opentelemetry = {
  #   package = pkgs.opentelemetry-collector-contrib;
  #   configFile = pkgs.writeText "config.yaml" ''
  #     recievers:
  #       systemd:

  #     service:
  #       pipelines:
  #         metrics:
  #           recievers: [systemd]
  #           exporters: []
  #   '';
  # };
  
  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "acme@thenextusername.xyz";
  #   certs = {
  #     "${hostName}.thenextusername.xyz" = {
  #       domain = "${hostName}.thenextusername.xyz";
  #       dnsProvider = "rfc2136";
  #       environmentFile = pkgs.writeText "rfc2136-environment" ''
  #         RFC2136_NAMESERVER=peony.homelab.thenextusername.xyz
  #         RFC2136_TSIG_KEY=peony-${hostName}.
  #         RFC2136_TSIG_FILE=/etc/secrets/peony-${hostName}.key
  #       '';
  #     };
  #   };
  # };

  homelab.rootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLro/iRxNvVdLn1lKfTOWHYsAFf6dfeujj1DMxhHCEB tnu@aster"
  ];
}
