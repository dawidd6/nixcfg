{
  lib,
  inputs,
  pkgs,
  ...
}: {
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

  nix.gc.automatic = true;
  nix.gc.frequency = "weekly";
  nix.gc.options = "--delete-older-than 14d";

  nix.package = lib.mkDefault pkgs.nix;
  nix.settings.extra-substituters = ["https://dawidd6.cachix.org"];
  nix.settings.extra-trusted-public-keys = ["dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="];
  nix.settings.warn-dirty = false;
}
