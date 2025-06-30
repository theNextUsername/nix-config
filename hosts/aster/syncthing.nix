{ ... }:

{
    services.syncthing = {
        enable = true;
        group = "users";
        user = "tnu";
        dataDir = "/home/tnu/Main";
        configDir = "/home/tnu/Documents/.config/syncthing";
        overrideDevices = true;
        overrideFolders = true;
        settings = {
            devices = {
                "windows11-desktop02" = { id = "4FCIEXC-D7IPWPT-N7ETF3K-73NWFJG-7IAXLLV-4AU4CDH-OEBMOTD-VZHCDQP"; };
            };
            folders = {
                "Main" = {
                    path = "/home/tnu/Main";
                    devices = [ "windows11-desktop02" ];
                    versioning = {
                        type = "simple";
                        params.keep = "10";
                    };
                    ignorePerms = false;
                };
            };
        };
    };
}
