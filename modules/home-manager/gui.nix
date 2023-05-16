{ inputs, outputs, lib, config, pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = (with pkgs; [
    gnome.gnome-tweaks
    google-chrome
    keepassxc
    vorta
    vscode
  ]) ++ (with outputs.packages.x86_64-linux; [
    ubuntu-font
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    gtk-title-bar
  ]);

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) (with pkgs.gnomeExtensions; [
        appindicator
        gtk-title-bar
      ]);
      disabled-extensions = [];
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      font-name = "Ubuntu 11";
      document-font-name = "FreeSans 11";
      monospace-font-name = "Ubuntu Mono 13";
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Bold 11";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "kgx";
      name = "Terminal";
    };
  };
}
