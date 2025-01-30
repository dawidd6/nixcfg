{ pkgs, ... }:
if builtins.pathExists ~/ghorg/brcloud then
  {
    imports = [ ./common.nix ];

    home.packages = [ pkgs.onedrive ];

    systemd.user.services.onedrive = {
      Unit.Description = "Onedrive sync service";
      Install.WantedBy = [ "default.target" ];
      Service = {
        Environment = [
          "Environment=HTTP_PROXY=http://10.144.1.10:8080"
          "Environment=HTTPS_PROXY=http://10.144.1.10:8080"
        ];
        Type = "simple";
        ExecStart = ''
          ${pkgs.onedrive}/bin/onedrive --monitor --confdir=%h/.config/onedrive
        '';
        Restart = "on-failure";
        RestartSec = 30;
        RestartPreventExitStatus = 3;
      };
    };

    home.stateVersion = "22.11";
  }
else
  {
    imports = [ ./common.nix ];

    programs.ssh.matchBlocks."*".extraOptions.IdentityAgent = "~/.1password/agent.sock";

    programs.git.extraConfig.gpg.ssh.program = "op-ssh-sign";

    programs.fish.functions = {
      hub = {
        body = "command op plugin run -- gh $argv";
        wraps = "gh";
      };
    };

    home.stateVersion = "24.11";
  }
