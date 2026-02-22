{ pkgs, config, self, ... }:
# let
#   hostName = config.networking.hostName;
# in
{
  services.prometheus.enable = true;
  services.prometheus = {
    stateDir = "prometheus2";
    extraFlags = [
      "--web.enable-otlp-receiver"
    ];
    globalConfig = {
      scrape_interval = "10s";
      # storage.tsdb.out_of_order_time_window = "30m";
    };
    scrapeConfigs = [
      {
        job_name = "opentelemetry-collector";
        static_configs = [{
          targets = [
            "localhost:9091"
          ];
        }];
      }
    ];
  };

  services.grafana.enable = true;
  services.grafana = {
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 3000;
      };
    };
  };

  services.opentelemetry-collector.enable = true;
  services.opentelemetry-collector = {
    package = pkgs.opentelemetry-collector-contrib;
    # package = pkgs.buildOtelCollector {
    #   pname = "otel-collector-node";
    #   otelBuilderPackage = pkgs.opentelemetry-collector-builder.overrideAttrs (prev: final: {
    #     version = "0.146.0";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "open-telemetry";
    #       repo = "opentelemetry-collector";
    #       rev = "cmd/builder/v${final.version}";
    #       hash = "sha256-ntRWAYbVbtZBqewXx4+YCZspRr+wSE2iGgmH8PEfj5o=";
    #      };
    #     vendorHash = "sha256-my52TJ2D9RXbIqSaY4PHwrYVd93dXXeg/srXHt1jcoI=";
    #     proxyVendor = true;
    #   });
    #   version = "0.0.1";
    #   config = {
    #     recievers = [
    #       {gomod = "github.com/open-telemetry/opentelemetry-collector-contrib/receiver/systemdreceiver v0.146.0";}
    #       {gomod = "github.com/open-telemetry/opentelemetry-collector-contrib/receiver/hostmetricsreceiver v0.146.0";}
    #     ];
    #     exporters = [
    #       {gomod = "github.com/open-telemetry/opentelemetry-collector-contrib/exporter/prometheusexporter v0.146.0";}
    #     ];
    #   };
    #   vendorHash = "sha256-my52TJ2D9RXbIqSaY4PHwrYVd93dXXeg/srXHt1jcoI=";
    # };
    configFile = ./otel-config.yaml;
  };
  
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
