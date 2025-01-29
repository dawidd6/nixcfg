{ mkModule, ... }:
mkModule {
  onNixos = {
    programs.nano.enable = false;
  };
}
