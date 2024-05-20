{pkgs, ...}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    gtk-title-bar
    pano
  ];
in {
  home.packages = extensions;

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) extensions;
      disabled-extensions = [];
    };
    "org/gnome/shell/extensions/pano" = {
      history-length = 50;
      keep-search-entry = false;
      link-previews = false;
      open-links-in-browser = false;
      paste-on-select = false;
      play-audio-on-copy = false;
      send-notification-on-copy = false;
      watch-exclusion-list = false;
    };
  };
}
