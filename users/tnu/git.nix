{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    git
    git-credential-manager
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "theNextUsername";
      user.email = "thenextusername@thenextusername.xyz";
      core.editor = config.home.sessionVariables.EDITOR;
      credential.helper = "manager";
      credential."https://github.com".username = "theNextUsername";
      credential."https://coffea.thenextusername.xyz".provider = "generic";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
    };
  };

}
