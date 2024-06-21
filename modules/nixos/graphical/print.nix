{ pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  services.avahi.publish.userServices = true;

  hardware.sane.enable = true;
  hardware.sane.openFirewall = true;
  hardware.sane.extraBackends = [ pkgs.hplip ];
}
