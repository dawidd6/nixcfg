{ mkModule, ... }:
mkModule {
  onNixos = {
    documentation.doc.enable = false;
    documentation.info.enable = false;
    documentation.nixos.enable = false;
  };
}
