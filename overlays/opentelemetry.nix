(final: prev: {
  opentelemetry-collector-builder = final.callPackage ../packages/opentelemetry-collector/builder.nix {};
  opentelemetry-collector-releases = final.callPackage ../packages/opentelemetry-collector/releases.nix {
    opentelemetry-collector-builder = final.opentelemetry-collector-builder;
  };
})
