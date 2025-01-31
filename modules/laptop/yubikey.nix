{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.yubioath-flutter
    pkgs.yubikey-manager
  ];
}
