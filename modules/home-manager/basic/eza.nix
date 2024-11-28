_: {
  programs.eza.enable = true;
  programs.eza.git = true;
  programs.eza.icons = true;
  programs.eza.extraOptions = [
    "--group-directories-first"
    "--header"
    "--time-style=long-iso"
  ];
}
