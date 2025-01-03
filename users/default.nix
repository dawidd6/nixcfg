{
  inputs,
  outputs,
  lib,
  ...
}:
let
  mkHome =
    userName:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./${userName} ];
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          userName
          ;
      };
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkHome
