{pkgs, ...}: let
  ubuntu-font-family = pkgs.callPackage ../../packages/ubuntu-font-family.nix {};
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    gtk-title-bar
    hibernate-status-button
    pano
  ];
in {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs;
    [
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
    ]
    ++ [ubuntu-font-family]
    ++ extensions;

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) extensions;
      disabled-extensions = [];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      clock-show-weekday = true;
      clock-show-seconds = true;
      show-battery-percentage = true;
      font-name = "Ubuntu 11";
      document-font-name = "FreeSans 11";
      monospace-font-name = "Ubuntu Mono 13";
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Bold 11";
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
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
    "org/gnome/shell/extensions/pano" = {
      send-notification-on-copy = false;
    };
  };
}
