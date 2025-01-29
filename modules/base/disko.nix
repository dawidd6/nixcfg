{ mkModule, inputs, ... }:
mkModule {
  onNixos = {
    imports = [
      inputs.disko.nixosModules.default
    ];
  };
}
