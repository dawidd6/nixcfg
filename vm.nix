{
  system ? builtins.currentSystem,
  username ? builtins.getEnv "USER",
  homedir ? builtins.getEnv "HOME",
  desktop ? true,
  nixpkgs ? ../nixpkgs,
  home-manager ? ../home-manager,
  ...
}: rec {
  vmBuild = vmSystem.config.system.build.vm;
  vmSystem = import (nixpkgs + "/nixos/lib/eval-config.nix") {
    inherit system;
    modules = [
      ({pkgs, ...}: {
        environment.systemPackages = with pkgs; [
          hieroglyphic
        ];

        home-manager.users.${username} = {pkgs, ...}: {
          home.packages = with pkgs; [
            neovim
          ];
        };
      })
      ({config, ...}: {
        imports = [(home-manager + "/nixos")];
        services.getty.autologinUser = username;
        users.users.${username} = {
          isNormalUser = true;
          extraGroups = ["wheel"];
          password = "";
        };
        home-manager.users.${username} = {osConfig, ...}: {
          home.stateVersion = osConfig.system.nixos.release;
        };
        security.sudo.wheelNeedsPassword = false;
        services.xserver.enable = desktop;
        services.xserver.displayManager.gdm.enable = config.services.xserver.enable;
        services.xserver.desktopManager.gnome.enable = config.services.xserver.enable;
        services.displayManager.autoLogin.enable = config.services.xserver.enable;
        services.displayManager.autoLogin.user = username;
        system.stateVersion = config.system.nixos.release;
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
        };
      })
    ];
  };
}
