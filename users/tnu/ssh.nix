{ pkgs, ... }:

{
  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
  };

  systemd.user.services.add-id_ed25519 = {
    Unit = {
      Description = "Add default ssh key to ssh-agent";
      PartOf = "graphical-session.target";
      After = [
        "graphical-session.target"
        "niri.service"
        "ssh-agent.service"
      ];
      Requires = "ssh-agent.service";
      Requisite = "graphical-session.target";
    };
    
    Install = {
      WantedBy = [ "niri.service" ];
    };
    
    Service = {
      Environment = "SSH_ASKPASS=${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      ExecStart = "${pkgs.openssh}/bin/ssh-add %h/.ssh/id_ed25519";
    };
  };
}
