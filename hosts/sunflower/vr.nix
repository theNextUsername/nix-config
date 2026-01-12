{ pkgs, ... }:

{
  programs.steam = {
    package = pkgs.steam.override {
      extraProfile = ''
        # Fixes timezones on VRChat
        unset TZ
        # Allows Monado to be used
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
      '';
    };
  };
  
  services.monado = {
    enable = true;
    defaultRuntime = true;
    package = pkgs.monado.override {
      openhmd = pkgs.callPackage (
        { fetchFromGitHub, libusb1, opencv }:

        pkgs.openhmd.overrideAttrs (final: prev: {
          src = fetchFromGitHub {
            owner = "thaytan";
            repo = "OpenHMD";
            rev = "04f5276bfc679968ceea62e4d1df6cbe6376941c";
            hash = "sha256-Av8Jgta47dgsAsMdKV3It+MCzcaHmbMkCc4KZIbjeK0=";
          };
          buildInputs = prev.buildInputs ++ [ libusb1 opencv ];
        })
      ) {};
    };
  };

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    IPC_EXIT_ON_DISCONNECT = "1";
  };

  programs.git.lfs.enable = true;
}
