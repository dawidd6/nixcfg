{
  hostDir,
  ...
}:
{
  system.stateVersion = import "${hostDir}/version.nix";
}
