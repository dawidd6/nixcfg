{
  pkgs,
  lib,
  ...
}:
let
  gnomeExtensions = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-indicator
  ];
in
{
  services.displayManager.autoLogin.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.gnome.excludePackages = [ pkgs.gnome-tour ];

  environment.systemPackages =
    (with pkgs; [
      dconf-editor
      eyedropper
      filezilla
      firefox
      fritzing
      gimp
      gnome-power-manager
      gnome-tweaks
      google-chrome
      gscan2pdf
      inkscape
      keepassxc
      krita
      libreoffice
      lutris
      mission-center
      pavucontrol
      quickemu
      remmina
      signal-desktop
      spotify
      vscode
      yubioath-flutter
    ])
    ++ gnomeExtensions;

  fonts.packages = with pkgs; [
    ubuntu-classic
    (nerdfonts.override {
      fonts = [
        "Ubuntu"
        "UbuntuMono"
      ];
    })
  ];

  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
        };
        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
        };
      };
    }
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false; # enables user extensions
          enabled-extensions = map (extension: extension.extensionUuid) gnomeExtensions;
        };
        "org/gnome/desktop/interface" = {
          font-antialiasing = "rgba";
          font-name = "Ubuntu 11";
          document-font-name = "FreeSans 11";
          monospace-font-name = "UbuntuMono Nerd Font Regular 13";
          color-scheme = "prefer-dark";
          clock-show-weekday = true;
          clock-show-seconds = true;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
          titlebar-font = "Ubuntu Bold 11";
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
        };
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-battery-type = "nothing";
          sleep-inactive-ac-type = "nothing";
          idle-dim = false;
          idle-brightness = lib.gvariant.mkInt32 100;
        };
        "org/gnome/desktop/session" = {
          idle-delay = lib.gvariant.mkUint32 0;
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-applications-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-windows = [ "<Alt>Tab" ];
          switch-windows-backward = [ "<Shift><Alt>Tab" ];
          show-desktop = [ "<Super>d" ];
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
        "org/gtk/gtk4/settings/file-chooser" = {
          show-hidden = true;
        };
        "org/gnome/desktop/screensaver" = {
          lock-enabled = false;
        };
      };
    }
  ];

  # https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
