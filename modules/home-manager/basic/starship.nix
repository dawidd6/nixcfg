{...}: {
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 2000;
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
