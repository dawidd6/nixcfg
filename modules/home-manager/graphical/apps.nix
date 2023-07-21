{pkgs, ...}: let
  apps = with pkgs; [
    filezilla
    gimp
    gnome.gnome-tweaks
    google-chrome
    gpick
    inkscape
    keepassxc
    pavucontrol
    spotify
    virt-manager
    vorta
    vscode
  ];
in {
  home.packages = apps;

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = builtins.concatLists (builtins.map (p: builtins.attrNames (builtins.readDir (p.outPath + "/share/applications"))) apps);
    };
    "org/virt-manager/virt-manager" = {
      system-tray = true;
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
