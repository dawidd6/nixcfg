_: {
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config = {
    global = {
      warn_timeout = "15m";
      hide_env_diff = true;
    };
  };
}
