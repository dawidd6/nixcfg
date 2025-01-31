{
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.bat ];

  programs.fish.shellAliases = {
    bat = "bat --pager='less -FR' --theme='Visual Studio Dark+'";
    cat = "bat";
  };
}
