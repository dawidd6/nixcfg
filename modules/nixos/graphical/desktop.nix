{
  pkgs,
  config,
  lib,
  ...
}: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # https://github.com/NixOS/nixpkgs/pull/282317
  security.pam.services.gdm-autologin.text = lib.mkForce ''
    auth      requisite     pam_nologin.so
    auth      required      pam_succeed_if.so uid >= 1000 quiet
    auth      optional      ${pkgs.gnome.gdm}/lib/security/pam_gdm.so
    auth      optional      ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so
    auth      required      pam_permit.so

    account   sufficient    pam_unix.so

    password  requisite     pam_unix.so nullok yescrypt

    session   optional      pam_keyinit.so revoke
    session   include       login
  '';

  # https://github.com/NixOS/nixpkgs/issues/171136
  security.pam.services.login.fprintAuth = false;
}
