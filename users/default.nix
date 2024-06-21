{
  inputs,
  outputs,
  lib,
  ...
}:
let
  mkHome =
    username:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./${username}/home.nix ];
      extraSpecialArgs = {
        inherit inputs outputs;
      };
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkHome
