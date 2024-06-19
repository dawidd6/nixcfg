{lib, ...}: {
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;

  # TODO: upstream this (disable completions generation)
  environment.etc."fish/generated_completions".text = lib.mkForce "";
}
