{
  inputs,
  hostname,
  ...
}:
{
  system.stateVersion = import "${inputs.self}/hosts/${hostname}/version.nix";
}
