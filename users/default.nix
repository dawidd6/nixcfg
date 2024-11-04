{
  inputs,
  outputs,
  lib,
  ...
}:
let
  mkHome =
    userName:
    let
      version = import ./${userName}/version.nix;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./${userName}/home.nix ];
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          userName
          version
          ;
      };
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkHome
