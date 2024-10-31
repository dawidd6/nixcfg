{
  userDir,
  ...
}@args:
{

  home.stateVersion =
    if (args ? osConfig) then args.osConfig.system.stateVersion else import "${userDir}/version.nix";
}
