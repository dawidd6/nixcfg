{
  inputs,
  lib,
  pkgs,
  config,
  mkModule,
  ...
}:
let
  asGB = size: toString (size * 1024 * 1024 * 1024);
in
mkModule {
  onNixos = {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];

    nix.channel.enable = false;

    nix.daemonCPUSchedPolicy = "idle";
    nix.daemonIOSchedClass = "idle";

    nix.settings.trusted-users = [
      "@wheel"
      "root"
    ];
  };

  onHome = {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
    ];
  };

  onAny = {
    nix.package = pkgs.nix;

    nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nix.nixPath = lib.mapAttrsToList (name: _: "${name}=flake:${name}") inputs;

    nix.settings.nix-path = config.nix.nixPath;
    nix.settings.flake-registry = "";
    nix.settings.warn-dirty = false;
    nix.settings.min-free = asGB 10;
    nix.settings.max-free = asGB 50;
    nix.settings.experimental-features = "nix-command flakes";
    nix.settings.auto-optimise-store = true;

    nix.settings.extra-substituters = [ "https://dawidd6.cachix.org" ];
    nix.settings.extra-trusted-public-keys = [
      "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="
    ];
  };
}
