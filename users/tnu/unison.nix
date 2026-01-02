{ pkgs, ... }:

{
  services.unison.enable = true;
  services.unison = {
    pairs = {
      tuber = {
        commandOptions = {
          ignore = [
            "Name .*"
            "Path tmp"
          ];
          atomic = [
            "Name .git"
          ];
        };
        roots = [
          "/home/tnu"
          "ssh://tuber/"
        ];
      };
    };
  };
}
