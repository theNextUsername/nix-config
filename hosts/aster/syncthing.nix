{ ... }:

{
    services.syncthing = {
        enable = true;
        group = "users";
        user = "tnu";
        dataDir = "/home/tnu/";
        configDir = "/home/tnu/.config/syncthing";
        overrideDevices = true;
        overrideFolders = true;
        settings = {
            devices = {
                "pixel" = { id = "NCP72H7-HSL2D5H-ME55OZB-F2FB2DL-QDYZBKK-ESZTUSF-XLZ4PEE-AGXSTAY"; };
            };
            folders = let
                defaultVersioning = {
                    type = "simple";
                    params.keep = "10";
                };
            in {
                # "main" = {
                #     path = "/home/tnu/main";
                #     devices = [ "pixel" ];
                #     versioning = defaultVersioning;
                #     ignorePerms = false;
                # };
                "store" = {
                    path = "/home/tnu/store";
                    devices = [ "pixel" ];
                    versioning = defaultVersioning;
                    ignorePerms = false;
                };
                "tags" = {
                    path = "/home/tnu/tags";
                    devices = [ "pixel" ];
                    versioning = defaultVersioning;
                    ignorePerms = false;
                };
            };
        };
    };
}
