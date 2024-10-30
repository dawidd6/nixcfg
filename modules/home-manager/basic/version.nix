{
  inputs,
  username,
  ...
}@args:
{

  home.stateVersion =
    if (args ? osConfig) then
      args.osConfig.system.stateVersion
    else
      import "${inputs.self}/users/${username}/version.nix";
}
