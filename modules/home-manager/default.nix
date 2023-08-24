{lib, ...}: {
  basic = {
    imports = lib.filesystem.listFilesRecursive ./basic;
  };
  graphical = {
    imports = lib.filesystem.listFilesRecursive ./graphical;
  };
}
