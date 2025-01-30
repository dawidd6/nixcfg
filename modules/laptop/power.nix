{ mkModule, ... }:
mkModule {
  onNixos = {
    powerManagement.enable = true;
    powerManagement.powertop.enable = true;

    services.thermald.enable = true;
    services.upower.enable = true;
  };
}
