_: {
  environment.etc."direnv/direnv.toml".text = ''
    [global]
    hide_env_diff = true
    warn_timeout = "15m"
  '';

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
