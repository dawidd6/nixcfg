{ outputs, lib, ... }@args:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  nixpkgs.overlays = lib.mkIf (!args ? osConfig) [
    outputs.overlays.default
  ];

  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
}
