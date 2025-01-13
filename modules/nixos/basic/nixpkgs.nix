{
  outputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ outputs.overlays.default ];
}
