{ ... }:

{
  services.gitDaemon = {
    enable = true;
    basePath = "/srv/git";
    exportAll = false;
  }; 
}
