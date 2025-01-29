{
  pkgs,
  mkModule,
  ...
}:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.bat ];
  };

  onHome = {
    home.packages = [ pkgs.bat ];
  };

  onAny = {
    programs.fish.shellAliases = {
      bat = "bat --pager='less -FR' --theme='Visual Studio Dark+'";
      cat = "bat";
    };
  };
}
