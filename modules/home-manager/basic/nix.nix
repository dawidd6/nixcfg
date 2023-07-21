{
  lib,
  inputs,
  ...
}: {
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
