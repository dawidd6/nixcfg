{
  lib,
  ...
}:
{
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
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          clock-show-weekday = true;
          clock-show-seconds = true;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
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
}
