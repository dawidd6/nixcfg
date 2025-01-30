{
  mkModule,
  pkgs,
  inputs,
  ...
}:
mkModule {
  onNixos = {
    environment.systemPackages = [ inputs.self.packages.${pkgs.system}.scripts ];
  };

  onHome = {
    home.packages = [ inputs.self.packages.${pkgs.system}.scripts ];
  };
}
