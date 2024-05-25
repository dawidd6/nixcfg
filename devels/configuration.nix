{
  pkgs,
  config,
  username,
  desktop,
  homedir,
  ...
}: {
  environment.systemPackages = with pkgs; [
  ];

  home-manager.users.${username} = ./home.nix;

  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = username;
  services.displayManager.autoLogin.enable = config.services.xserver.enable;
  services.displayManager.autoLogin.user = username;
  services.xserver.enable = desktop;
  services.xserver.displayManager.gdm.enable = config.services.xserver.enable;
  services.xserver.desktopManager.gnome.enable = config.services.xserver.enable;

  system.stateVersion = config.system.nixos.release;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    password = "";
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
  };
}
