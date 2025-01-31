_: {

  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 5000;
      add_newline = false;
      line_break = {
        disabled = true;
      };
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[➜](bold red) ";
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
