{ mkModule, pkgs, ... }:
mkModule {
  onNixos = {
    environment.systemPackages = [
      pkgs.yubioath-flutter
      pkgs.yubikey-manager
    ];
  };

  onHome = {
    home.packages = [
      pkgs.yubikey-manager
    ];
  };
}
