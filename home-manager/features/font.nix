{ inputs, config, pkgs, ... }: {
  fonts.fontconfig.enable = true;

  # TODO: pin to v0.83
  home.packages = with pkgs; [
    ubuntu_font_family
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Ubuntu 11";
      document-font-name = "FreeSans 11";
      monospace-font-name = "Ubuntu Mono 13";
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Bold 11";
    };
  };
}
