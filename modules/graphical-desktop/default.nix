{ pkgs, lib, config, ... }:

{
  imports = [
    ./sddm.nix
  ];

  users.users.tnu = {
    extraGroups = [ "wheel" "networkmanager" ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
  };
  programs.nm-applet.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
 
  # Configure split DNS
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";
  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];


  environment.etc."NetworkManager/dnsmasq.d/servers".text = ''
    server=/homelab.thenextusername.xyz/192.168.2.4 
  '';

  # enable auto-unlock of kwallet taken from the plasma.nix module in nixpkgs
  security.pam.services = {
    swaylock = {}; # Allow swaylock to be enabled in home manager
    login.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };
    kde = {
      allowNullPassword = false;
      kwallet = {
        enable = true;
        package = pkgs.kdePackages.kwallet-pam;
      };
    };
    kde-fingerprint = lib.mkIf config.services.fprintd.enable { fprintAuth = true; };
    kde-smartcard = lib.mkIf config.security.pam.p11.enable { p11Auth = true; };
  };

  xdg.portal.extraPortals = [
      pkgs.kdePackages.kwallet
  ];

  # Automatically enabled by niri, disabled to use kwallet instead
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  # Cannot figure out how to replace this for Chromium apps
  services.dbus.packages = [ pkgs.nautilus ];

  services.udisks2.enable = true;
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.libinput.enable = true;
  services.flatpak.enable = true;

  system.autoUpgrade = {
    enable = true;
    upgrade = false;
    runGarbageCollection = true;
    persistent = true;
    operation = "boot";
    dates = "daily";
    flake = "github:theNextUsername/nix-config";
  };
  systemd.services = {
    "service-success@" = {
      unitConfig = {
        Description = "Notify all users of successful service completion";
      };
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.dbus}/bin/dbus-send --system / net.nuetzlich.SystemNotifications.Notify \"string:%i was successful\"";
      };
    };
    "service-failure@" = {
      unitConfig = {
        Description = "Notify all users of service failure";
      };
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.dbus}/bin/dbus-send --system / net.nuetzlich.SystemNotifications.Notify \"string:%i failed!!\"";
      };
    };
    nixos-upgrade = {
      unitConfig = {
        OnFailure = "service-failure@%n.service";
        OnSuccess = "service-success@%n.service";
      }; 
    };
  };
  
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
    wget
    gitFull
    nil
    bash-language-server
    wireguard-tools
    libreoffice-still
    hunspell
    hunspellDicts.en_US
    thunderbird
    wl-clipboard-rs
    xwayland-satellite
    ssh-to-age
    proxmox-backup-client
  ];
}

