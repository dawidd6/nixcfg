{
  inputs,
  outputs,
  lib,
  ...
}: let
  mkHome = username:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [
          outputs.overlays.additions
          outputs.overlays.modifications
        ];
      };
      modules = [./${username}/home.nix];
      extraSpecialArgs = {inherit inputs outputs;};
    };
in
  lib.genAttrs (builtins.attrNames (lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.))) mkHome
