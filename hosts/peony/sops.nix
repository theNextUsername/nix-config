{ ... }:

{
  sops.validateSopsFiles = false;
  sops.defaultSopsFile = "/root/.nix-secrets/secrets/global.yaml";
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets.example_key = {
    mode = "0444";
  };
}
