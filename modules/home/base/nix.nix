{
  lib,
  inputs,
  pkgs,
  config,
  ...
}@args:
let
  asGB = size: toString (size * 1024 * 1024 * 1024);
in
{
  nix.package = lib.mkIf (!args ? osConfig) pkgs.nix;

  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  nix.nixPath = lib.mapAttrsToList (name: _: "${name}=flake:${name}") inputs;

  nix.settings.flake-registry = "";
  nix.settings.warn-dirty = false;
  nix.settings.min-free = asGB 10;
  nix.settings.max-free = asGB 50;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.nix-path = config.nix.nixPath;
  nix.settings.extra-substituters = [ "https://dawidd6.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="
  ];
}
