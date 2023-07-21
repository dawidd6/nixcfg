{pkgs, ...}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    gtk-title-bar
    hibernate-status-button
    pano
    user-themes
  ];
in {
  home.packages = extensions;

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) extensions;
      disabled-extensions = [];
    };
    "org/gnome/shell/extensions/pano" = {
      send-notification-on-copy = false;
    };
  };
}
