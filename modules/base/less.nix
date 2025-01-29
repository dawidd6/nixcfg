{ mkModule, ... }:
mkModule {
  onAny = {
    programs.less.enable = true;
  };
}
