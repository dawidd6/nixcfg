{
  config,
  lib,
  ...
}:

{
  # TODO: upstream this (disable completions generation)
  environment.etc."fish/generated_completions".text = lib.mkForce "";

  #documentation.man.generateCaches = false;

  users.defaultUserShell = config.programs.fish.package;

  programs.fish = {
    enable = true;
    useBabelfish = true;
    interactiveShellInit = ''
      set fish_color_command green
      set fish_color_param normal
      set fish_color_error red --bold
      set fish_color_normal normal
      set fish_color_comment brblack
      set fish_color_quote yellow
    '';
  };
}
