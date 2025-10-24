{ pkgs, ... }:

{
  imports = [ ./waybar.nix ./niri.nix ];
  home.username = "tnu";
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "ewrap";
    BROWSER = "librewolf";
    TERMINAL = "alacritty";
  };
  home.shellAliases = {
    signal-desktop = "signal-desktop --password-store=kwallet6";
    nnn = "nnn -eE";
  };
  home.packages = with pkgs; [
    fastfetch
    (nnn.override { extraMakeFlags = [ "O_COLEMAK=1" ]; })
    zip
    xz
    unzip
    dnsutils
    nmap
    which
    tree
    gnupg
    glow
    lsof
    ethtool
    pciutils
    usbutils
    git
    git-credential-manager
    remmina
    kitty
    hyprpolkitagent
    krita
    calc
    scrcpy
    signal-desktop
    obs-studio
    calc
    vlc
    wireshark
    marksman
    vscode-langservers-extracted
    ungoogled-chromium
    tor-browser
    protonvpn-gui
    monero-gui
    networkmanagerapplet
    rclone
    age
    (writeShellApplication {
      name = "ewrap";
      runtimeInputs = [ alacritty helix ];
      text = ''
        alacritty -e hx "$*" &
      '';
    })
  ]
  ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  xdg.desktopEntries = {
    signal = {
      categories = [ "Network" "InstantMessaging" "Chat" ];
      comment = "Private messaging from your desktop";
      exec = "signal-desktop %U --password-store=kwallet6";
      icon = "signal-desktop";
      mimeType = [ "x-scheme-handler/sgnl" "x-scheme-handler/signalcaptcha" ];
      name = "Signal";
      terminal = false;
      type = "Application";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };
  
  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "theNextUsername";
    userEmail = "thenextusername@thenextusername.xyz";
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "theNextUsername";
    extraConfig.credential.credentialStore = "cache";
    extraConfig.init.defaultBranch = "main";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
    '';
  };

  programs.alacritty.enable = true;
  programs.helix.enable = true;

  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = true;
    };
    policies = {
      DefaultDownloadDirectory = "\${home}/tmp";
      ExtensionSettings =  {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "http://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles."u98pz70j.default".extensions.force = true;
  };

  stylix.targets.librewolf = {
    colorTheme.enable = true;
    profileNames = [ "u98pz70j.default" ];
  };

  services.kdeconnect.enable = true;

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.nnn}/bin/nnn -eE";
      };
    };
  };


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
