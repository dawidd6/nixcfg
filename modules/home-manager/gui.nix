{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages =
    (with pkgs; [
      copyq
      filezilla
      gimp
      google-chrome
      gpick
      inkscape
      keepassxc
      pavucontrol
      spotify
      virt-manager
      vorta
      vscode
    ])
    ++ (with pkgs.gnome; [
      gnome-tweaks
    ])
    ++ (with pkgs; [
      # TODO: pin to v0.83
      ubuntu_font_family
    ])
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      gtk-title-bar
      hibernate-status-button
    ]);

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) (with pkgs.gnomeExtensions; [
        appindicator
        gtk-title-bar
        hibernate-status-button
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
      clock-show-weekday = true;
      clock-show-seconds = true;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Bold 11";
      button-layout = "appmenu:minimize,maximize,close";
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
  };
}
