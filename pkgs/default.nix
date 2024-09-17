{
  self,
  pkgs,
}:
{
  ubuntu-font-family = pkgs.callPackage ./ubuntu-font-family { };
  disko-install = pkgs.callPackage ./disko-install { inherit self; };
}
