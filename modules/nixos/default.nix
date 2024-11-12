{ lib, ... }:
lib.genAttrs (builtins.attrNames (lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.)))
  (dir: {
    imports = lib.filesystem.listFilesRecursive ./${dir};
  })
