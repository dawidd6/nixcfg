{ mkModule, pkgs, ... }:
mkModule {
  onNixos = {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    services.xserver.excludePackages = [ pkgs.xterm ];

    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  };
}
