{ mkModule, ... }:
mkModule {
  onNixos = {
    services.fwupd.enable = true;
  };
}
