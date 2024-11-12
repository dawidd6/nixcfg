{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  asGB = size: toString (size * 1024 * 1024 * 1024);
in
{
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  nix.nixPath = lib.mapAttrsToList (name: _: "${name}=flake:${name}") inputs;

  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";

  nix.settings.min-free = asGB 10;
  nix.settings.max-free = asGB 50;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.flake-registry = "";
  nix.settings.nix-path = config.nix.nixPath;
  nix.settings.substituters = [ "https://dawidd6.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="
  ];
  nix.settings.trusted-users = [
    "@wheel"
    "root"
  ];
  nix.settings.warn-dirty = false;

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
      fi
    '';
  };
}
