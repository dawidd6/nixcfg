{ mkModule, inputs, ... }:
mkModule {
  onHome = {
    xdg.configFile."nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';
  };

  onAny = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ inputs.self.overlays.default ];
  };
}
