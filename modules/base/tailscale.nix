{ mkModule, ... }:
mkModule {
  onNixos = {
    services.tailscale.enable = true;
  };
}
