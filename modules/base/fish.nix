{
  mkModule,
  userName,
  config,
  lib,
  ...
}:
mkModule {
  onNixos = {
    # TODO: upstream this (disable completions generation)
    environment.etc."fish/generated_completions".text = lib.mkForce "";

    documentation.man.generateCaches = false;

    programs.fish.useBabelfish = true;

    users.users."${userName}".shell = config.programs.fish.package;
  };

  onHome = {
    programs.fish.generateCompletions = false;
  };

  onAny = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_color_command green
        set fish_color_param normal
        set fish_color_error red --bold
        set fish_color_normal normal
        set fish_color_comment brblack
        set fish_color_quote yellow
      '';
    };
  };
}
