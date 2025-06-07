{ pkgs, ... }:

{
  imports = [ ./hypr.nix ];
  home.username = "tnu";
  home.homeDirectory = "/home/tnu";

  home.packages = with pkgs; [
    neofetch
    nnn
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
    protonmail-bridge-gui
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
  ];

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

  services.kdeconnect.enable = true;


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
