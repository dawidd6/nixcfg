{pkgs, ...}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-indicator
    gtk-title-bar
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
