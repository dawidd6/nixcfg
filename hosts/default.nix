{
  inputs,
  outputs,
  userName,
  lib,
  ...
}:
let
  mkNixOS =
    hostName:
    let
      hostDir = ./${hostName};
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          hostName
          hostDir
          userName
          ;
      };
      modules = [ /${hostDir}/configuration.nix ];
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkNixOS
