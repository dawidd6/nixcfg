{
  inputs,
  outputs,
  username,
  lib,
  ...
}:
let
  mkNixOS =
    hostname:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          hostname
          username
          ;
      };
      modules = [ ./${hostname}/configuration.nix ];
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkNixOS
