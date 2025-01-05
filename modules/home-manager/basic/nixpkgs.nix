{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}@args:
{
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
    overlays = [ outputs.overlays.default ];
  };

  nixpkgs = lib.mkIf (!args ? osConfig) {
    config.allowUnfree = true;
    overlays = [ outputs.overlays.default ];
  };

  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
}
