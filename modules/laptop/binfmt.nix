{ mkModule, ... }:
mkModule {
  onNixos = {
    boot.binfmt.emulatedSystems = [
      "armv7l-linux"
      "aarch64-linux"
    ];
  };
}
