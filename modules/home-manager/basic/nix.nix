{
  lib,
  inputs,
  ...
}: {
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

  nix.settings.substituters = ["https://dawidd6.cachix.org"];
  nix.settings.trusted-public-keys = ["dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="];
  nix.settings.warn-dirty = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
