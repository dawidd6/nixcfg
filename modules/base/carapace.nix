{ pkgs, mkModule, ... }:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.carapace ];
  };

  onHome = {
    home.packages = [ pkgs.carapace ];
  };

  onAny = {
    programs.fish.interactiveShellInit = ''
      ${pkgs.carapace}/bin/carapace nix-build | source
      ${pkgs.carapace}/bin/carapace nix-instantiate | source
      ${pkgs.carapace}/bin/carapace nix-shell | source
      ${pkgs.carapace}/bin/carapace nix-rebuild | source
    '';
  };
}
