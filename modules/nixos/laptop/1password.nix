{ userName, config, ... }:
{
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  programs._1password-gui.polkitPolicyOwners = [ userName ];

  programs.ssh.extraConfig = ''
    Host *
      IdentityAgent ~/.1password/agent.sock
  '';

  programs.git.config = {
    gpg."ssh".program = "${config.programs._1password-gui.package}/bin/op-ssh-sign";
  };
}
