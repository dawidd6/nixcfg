{pkgs, ...}: {
  home.packages = [pkgs.yaru-theme];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      icon-theme = "Yaru";
      gtk-theme = "Yaru-dark";
    };
    "org/gnome/desktop/sound" = {
      theme-name = "Yaru";
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Yaru-dark";
    };
  };
}
