{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
  nix.nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 14d";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
  ];
}
