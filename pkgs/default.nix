{
  pkgs,
  lib,
  ...
}:
lib.genAttrs (builtins.attrNames (
  lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)
)) (dir: pkgs.callPackage ./${dir}/package.nix { })
