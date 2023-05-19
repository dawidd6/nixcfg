{pkgs, ...}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    gtk-title-bar
    hibernate-status-button
    pano
  ];
in {
  home.packages = extensions;

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) extensions;
      disabled-extensions = [];
    };
  };
}
