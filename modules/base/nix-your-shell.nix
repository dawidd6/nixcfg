{ pkgs, mkModule, ... }:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.nix-your-shell ];
  };

  onHome = {
    home.packages = [ pkgs.nix-your-shell ];
  };

  onAny = {
    programs.fish.interactiveShellInit = ''
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
    '';
  };
}
