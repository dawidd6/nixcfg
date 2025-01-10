_: {
  programs.eza.enable = true;
  programs.eza.extraOptions = [
    "--group-directories-first"
    "--group"
    "--header"
    "--time-style=long-iso"
  ];
}
