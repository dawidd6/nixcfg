{ mkModule, ... }:
mkModule {
  onNixos = {
    security.sudo.wheelNeedsPassword = false;
  };
}
