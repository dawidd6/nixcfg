{
  system ? builtins.currentSystem,
  username ? builtins.getEnv "USER",
  homedir ? builtins.getEnv "HOME",
  desktop ? true,
  nixpkgs ? "${homedir}/nixpkgs",
  home-manager ? "${homedir}/home-manager",
  ...
}: rec {
  vmBuild = vmSystem.config.system.build.vm;
  vmSystem = import (nixpkgs + "/nixos/lib/eval-config.nix") {
    inherit system;
    modules = [
      ({
        config,
        lib,
        pkgs,
        ...
      }: {
        imports = [
          (home-manager + "/nixos")
          ./configuration.nix
        ];

        environment.systemPackages = [
          pkgs.xterm
        ];
        environment.loginShellInit = ''
          eval "$(resize)"
        '';

        home-manager = {
          users.${username} = ./home.nix;
          sharedModules = [
            {home.stateVersion = config.system.stateVersion;}
          ];
        };

        security.pam.services.sshd.allowNullPassword = true;
        security.sudo.wheelNeedsPassword = false;

        services.xserver.enable = desktop;
        services.displayManager.autoLogin.enable = config.services.xserver.enable;
        services.displayManager.autoLogin.user = username;
        services.xserver.displayManager.gdm.enable = config.services.xserver.enable;
        services.xserver.desktopManager.gnome.enable = config.services.xserver.enable;
        services.getty.autologinUser = lib.mkIf (!config.services.xserver.enable) username;
        services.openssh.enable = true;
        services.openssh.settings.PermitEmptyPasswords = "yes";

        system.stateVersion = config.system.nixos.release;

        users.users.${username} = {
          isNormalUser = true;
          extraGroups = ["wheel"];
          hashedPassword = "";
        };

        virtualisation.vmVariant = {
          virtualisation.cores = 4;
          virtualisation.memorySize = 4096;
          virtualisation.diskSize = 4096;
          virtualisation.diskImage = null;
          virtualisation.graphics = config.services.xserver.enable;
          virtualisation.qemu.options = [
            "-device virtio-vga"
            "-display gtk,grab-on-hover=on"
          ];
          virtualisation.sharedDirectories = {
            home = {
              source = homedir;
              target = "/mnt/home";
            };
          };
          virtualisation.forwardPorts = [
            {
              from = "host";
              host.port = 22222;
              guest.port = 22;
            }
          ];
        };
      })
    ];
  };
}
