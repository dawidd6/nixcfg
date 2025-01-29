{ mkModule, userName, ... }:
mkModule {
  onNixos = {
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = userName;

    # https://github.com/NixOS/nixpkgs/issues/103746
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
  };
}
