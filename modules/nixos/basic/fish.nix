{
  lib,
  config,
  userName,
  ...
}:
{
  # TODO: upstream this (disable completions generation)
  environment.etc."fish/generated_completions".text = lib.mkForce "";

  programs.fish.enable = true;
  programs.fish.useBabelfish = true;

  users.users."${userName}".shell = config.programs.fish.package;
}
