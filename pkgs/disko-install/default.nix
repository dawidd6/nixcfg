{ self, pkgs, ... }:
pkgs.writeShellApplication {
  name = "disko-install";
  text = ''
    set -x
    ${pkgs.lib.getExe pkgs.disko} --mode disko --argstr disk "$2" "${self}/hosts/$1/disko-config.nix"
    nixos-install --flake "${self}#$1"
    chroot /mnt passwd "$3"
  '';
}
