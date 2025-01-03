{
  inputs,
  outputs,
  lib,
  ...
}:
let
  mkNixOS =
    hostName:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          hostName
          ;
      };
      modules = [ ./${hostName} ];
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkNixOS
