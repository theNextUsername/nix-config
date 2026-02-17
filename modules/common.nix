{ pkgs, lib,  config, ... }:
let
  cfg = config.homelab;
  defaultUserKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBx7Q4gxioqzh7MlZ3JKHGGrOokqWkM20aHzSX2qjGnS tnu@aster" 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFL0KSsHKHrz+Qp4pcNgBes0Vzv1lCmJ4ZztuqItMB/ tnu@sunflower"
  ];
  defaultRootKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzZsCPr9p5bdDz1wyhKelr+y8KtqlQDrzK63nWy1wzj tnu@aster"
  ];
in
{
  options.homelab = {
    userKeys = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = defaultUserKeys;
      description = "List of keys to use for users.users.tnu.openssh.authorizedKeys.keys";
    };

    rootKeys = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = defaultRootKeys;
      description = "List of keys to use for users.users.root.openssh.authorizedKeys.keys";
    };
  };
  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.autoUpgrade.enable = lib.mkDefault true;
    system.autoUpgrade = {
      upgrade = false;
      runGarbageCollection = true;
      persistent = true;
      operation = "switch";
      dates = "daily";
      flake = "github:theNextUsername/nix-config";
    };

    nix.gc.options = "--delete-older-than 7d";
    nix.extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';

    networking.useDHCP = lib.mkDefault true;
    networking.domain = lib.mkDefault "homelab.thenextusername.xyz";
    networking.firewall.enable = true;

    time.timeZone = lib.mkDefault "America/Indiana/Indianapolis";

    environment.systemPackages = with pkgs; [
      helix
      git
    ];

    services.openssh.enable = lib.mkDefault true;
    services.openssh.openFirewall = true;

    users.users.tnu = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = cfg.userKeys;      
    };

    users.users.root = {
      openssh.authorizedKeys.keys = cfg.rootKeys;
    };
  };
}
