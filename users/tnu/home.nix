{ pkgs, lib, config, tnutils, ... }:
let
  tnupkgs = tnutils.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./ssh.nix
    ./waybar.nix
    ./niri.nix
    ./unison.nix
    ./vr.nix
  ];
  home.username = "tnu";
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "ewrap";
    BROWSER = "librewolf";
    TERMINAL = "alacritty";
    NNN_OPTS="eEC";
  };
  home.shellAliases = {
    signal-desktop = "signal-desktop --password-store=kwallet6";
    nnn = "n";
  };
  home.packages = with pkgs; [
    fastfetch
    btop
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
    screen
    signal-desktop
    obs-studio
    calc
    vlc
    wireshark
    marksman
    vscode-langservers-extracted
    tor-browser
    tlrc
    unison
    ungoogled-chromium
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
    tnupkgs.tag
    tnupkgs.diary
    tnupkgs.housekeep
    
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

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/main/desktop";
    documents = "${config.home.homeDirectory}/main/documents";
    download = "${config.home.homeDirectory}/tmp";
    music = "${config.home.homeDirectory}/main/music";
    pictures = "${config.home.homeDirectory}/main/pictures";
    publicShare = "${config.home.homeDirectory}/main/public";
    templates = "${config.home.homeDirectory}/main/templates";
    videos = "${config.home.homeDirectory}/main/videos";
    extraConfig = {
      TNU_TAG_DIR = "${config.home.homeDirectory}/tags";
      XDG_MOUNT_DIR = "${config.home.homeDirectory}/mnt";
      TNU_STORE_DIR = "${config.home.homeDirectory}/store";
      XDG_MISC_DIR = "${config.home.homeDirectory}/main/misc";
    };
  };

  xdg.configFile.kdeglobals.source =
  let
    themePackage = builtins.head (
      builtins.filter (
        p: builtins.match ".*stylix-kde-theme.*" (builtins.baseNameOf p) != null
      ) config.home.packages
    );
    colorSchemeSlug = lib.concatStrings (
      lib.filter lib.isString (builtins.split "[^a-zA-Z]" config.lib.stylix.colors.scheme)
    );
  in
  "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "theNextUsername";
      user.email = "thenextusername@thenextusername.xyz";
      credential.helper = "manager";
      credential."https://github.com".username = "theNextUsername";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      n ()
      {
          [ "''${NNNLVL:-0}" -eq 0 ] || {
              echo "nnn is already running"
              return
          }

          NNN_TMPFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

          # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
          # stty start undef
          # stty stop undef
          # stty lwrap undef
          # stty lnext undef

          # The command builtin allows one to alias nnn to n, if desired, without
          # making an infinitely recursive alias
          command nnn "$@"

          [ ! -f "$NNN_TMPFILE" ] || {
              . "$NNN_TMPFILE"
              rm -f -- "$NNN_TMPFILE" > /dev/null
          }
      }      
    '';
  };

  programs.alacritty.enable = true;
  programs.helix.enable = true;

  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "browser.search.defaultenginename" = "StartPage";
      "browser.search.order.1" = "StartPage";
      "general.autoScroll" = true;
      "identity.fxaccounts.enabled" = true;
      "middlemouse.paste" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = true;
      "webgl.disabled" = false;
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
