{
  lib,
  config,
  userName,
  ...
}:
{
  # TODO: upstream this (disable completions generation)
  environment.etc."fish/generated_completions".text = lib.mkForce "";

  documentation.man.generateCaches = false;

  programs.fish.enable = true;
  programs.fish.useBabelfish = true;

  users.users."${userName}".shell = config.programs.fish.package;
}
