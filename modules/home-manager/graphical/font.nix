{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    ubuntu-font-family
    (nerdfonts.override { fonts = [ "Ubuntu" "UbuntuMono" ]; })
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Ubuntu 11";
      document-font-name = "FreeSans 11";
      monospace-font-name = "UbuntuMono Nerd Font Regular 13";
      font-antialiasing = "rgba";
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Bold 11";
    };
  };
}
