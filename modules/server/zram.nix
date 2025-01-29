{ mkModule, ... }:
mkModule {
  onNixos = {
    zramSwap.enable = true;
  };
}
