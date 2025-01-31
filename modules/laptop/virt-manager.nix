{ userName, ... }:
{
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;

  users.users."${userName}".extraGroups = [ "libvirtd" ];
}
