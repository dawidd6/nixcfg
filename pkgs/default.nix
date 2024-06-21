{
  pkgs ? (import ../nixpkgs.nix) { },
}:
{
  ubuntu-font-family = pkgs.callPackage ./ubuntu-font-family { };
}
