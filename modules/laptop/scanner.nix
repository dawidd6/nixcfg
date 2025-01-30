{ mkModule, pkgs, ... }:
mkModule {
  onNixos = {
    hardware.sane.enable = true;
    hardware.sane.openFirewall = true;
    hardware.sane.extraBackends = [ pkgs.hplip ];
  };
}
