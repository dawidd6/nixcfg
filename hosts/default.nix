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
      version = import ./${hostName}/version.nix;
      home = import ./${hostName}/home.nix;
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          hostName
          userName
          version
          home
          ;
      };
      modules = [ ./${hostName}/configuration.nix ];
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkNixOS
