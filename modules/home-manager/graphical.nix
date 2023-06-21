{
  pkgs,
  lib,
  ...
}: let
  # Desktop font
  ubuntu-font-family = pkgs.callPackage ../../packages/ubuntu-font-family.nix {};
  # GNOME extensions
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    gtk-title-bar
    hibernate-status-button
    pano
    user-themes
  ];
  favorite-apps = with pkgs; [
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
  # Enable fonts configuration
  fonts.fontconfig.enable = true;

  # Graphical apps, fonts and extensions
  home.packages =
    [
      pkgs.yaru-theme
      ubuntu-font-family
    ]
    ++ extensions
    ++ favorite-apps;

  # GNOME preferences
  dconf.settings = {
    # Enable and disable extensions
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) extensions;
      disabled-extensions = [];
      favorite-apps = builtins.concatLists (builtins.map (p: builtins.attrNames (builtins.readDir (p.outPath + "/share/applications"))) favorite-apps);
    };
    # Desktop interface
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      icon-theme = "Yaru";
      gtk-theme = "Yaru-dark";
      clock-show-weekday = true;
      clock-show-seconds = true;
      show-battery-percentage = true;
      font-name = "Ubuntu 11";
      document-font-name = "FreeSans 11";
      monospace-font-name = "Ubuntu Mono 13";
    };
    # Windows preferences
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Bold 11";
      button-layout = "appmenu:minimize,maximize,close";
    };
    # Laptop touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    # Sound stuff
    "org/gnome/desktop/sound" = {
      theme-name = "Yaru";
    };
    # Calendar options
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    # Power management
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-battery-type = "nothing";
      sleep-inactive-ac-type = "nothing";
      idle-dim = false;
    };
    # Session settings
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };
    # Keybindings remapping
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };
    # Custom keybindings
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
    # Virt-manager preferences
    "org/virt-manager/virt-manager" = {
      system-tray = true;
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    # Pano extension settings
    "org/gnome/shell/extensions/pano" = {
      send-notification-on-copy = false;
    };
    # User themes extension settings
    "org/gnome/shell/extensions/user-theme" = {
      name = "Yaru-dark";
    };
  };
}
