{
  userName,
  config,
  ...
}:

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

  programs.fish.interactiveShellInit = ''
    function hub --wraps gh
      ${config.programs._1password.package}/bin/op plugin run -- gh $argv
    end
  '';
}
