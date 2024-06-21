{
  lib,
  inputs,
  pkgs,
  ...
}@args:
{
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

  nix.gc.automatic = true;
  nix.gc.frequency = "weekly";
  nix.gc.options = "--delete-older-than 14d";

  # https://github.com/nix-community/home-manager/issues/5465
  systemd.user.timers.nix-gc.Timer.Persistent = true;

  nix.package = lib.mkIf (!args ? osConfig) pkgs.nix;

  nix.settings.extra-substituters = [ "https://dawidd6.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="
  ];
  nix.settings.warn-dirty = false;
}
