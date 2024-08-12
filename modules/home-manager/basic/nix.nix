{
  lib,
  inputs,
  pkgs,
  ...
}@args:
let
  asGB = size: toString (size * 1024 * 1024 * 1024);
in
{
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

  # https://github.com/nix-community/home-manager/issues/5465
  systemd.user.timers.nix-gc.Timer.Persistent = true;

  nix.package = lib.mkIf (!args ? osConfig) pkgs.nix;

  nix.settings.min-free = asGB 10;
  nix.settings.max-free = asGB 50;
  nix.settings.extra-substituters = [ "https://dawidd6.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="
  ];
  nix.settings.warn-dirty = false;
}
