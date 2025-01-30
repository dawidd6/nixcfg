{ pkgs, mkModule, ... }:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.zoxide ];
  };

  onHome = {
    home.packages = [ pkgs.zoxide ];
  };

  onAny = {
    programs.fish.interactiveShellInit = ''
      ${pkgs.zoxide}/bin/zoxide init fish --cmd=cd | source
    '';
  };
}
