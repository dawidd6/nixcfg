{
  inputs,
  lib,
  ...
}: {
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
