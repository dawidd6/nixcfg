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
      userDir = ./${userName};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [ /${userDir}/home.nix ];
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          userName
          userDir
          ;
      };
    };
in
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) mkHome
