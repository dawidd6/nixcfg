{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

    outputs.nixosModules.basic
    outputs.nixosModules.graphical
  ];

  networking.hostName = "t14";

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  security.pam.services.login.fprintAuth = false;
  security.pam.services.gdm-fingerprint.text = ''
    auth       required                    pam_shells.so
    auth       requisite                   pam_nologin.so
    auth       requisite                   pam_faillock.so      preauth
    auth       required                    ${pkgs.fprintd}/lib/security/pam_fprintd.so
    auth       optional                    pam_permit.so
    auth       required                    pam_env.so
    auth       [success=ok default=1]      ${pkgs.gnome.gdm}/lib/security/pam_gdm.so
    auth       optional                    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so
    account    include                     login
    password   required                    pam_deny.so
    session    include                     login
    session    optional                    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start
  '';

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.initrd.luks.devices."luks-40a1edfa-0238-4f66-acb9-8ee70a8f03a9".device = "/dev/disk/by-uuid/40a1edfa-0238-4f66-acb9-8ee70a8f03a9";
  boot.initrd.luks.devices."luks-40a1edfa-0238-4f66-acb9-8ee70a8f03a9".keyFile = "/crypto_keyfile.bin";

  system.stateVersion = "23.05";
}
