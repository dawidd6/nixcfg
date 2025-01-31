{
  inputs,
  lib,
  config,
  ...
}:
{
  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";

  nix.settings.trusted-users = [
    "@wheel"
    "root"
  ];

  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  nix.nixPath = lib.mapAttrsToList (name: _: "${name}=flake:${name}") inputs;
  nix.settings.nix-path = config.nix.nixPath;
  nix.settings.warn-dirty = false;
  nix.settings.experimental-features = "nix-command flakes";
}
