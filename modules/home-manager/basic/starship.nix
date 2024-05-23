_: {
  programs.starship = {
    enable = true;
    # TODO: https://github.com/nix-community/home-manager/issues/5445
    enableFishIntegration = false;
    settings = {
      command_timeout = 5000;
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[➜](bold red) ";
      };
      line_break = {
        disabled = true;
      };
      status = {
        disabled = false;
        format = "[$status]($style) ";
      };
      nix_shell = {
        heuristic = true;
      };
    };
  };
}
