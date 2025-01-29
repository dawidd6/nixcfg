{ mkModule, ... }:
let
  settings = ''
    [global]
    hide_env_diff = true
    warn_timeout = "15m"
  '';
  path = "direnv/direnv.toml";
in
mkModule {
  onNixos = {
    environment.etc."${path}".text = settings;
  };

  onHome = {
    xdg.configFile."${path}".text = settings;
  };

  onAny = {
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  };
}
