{
  pkgs,
  ...
}:
{
  fonts.packages = with pkgs; [
    ubuntu-classic
    (nerdfonts.override {
      fonts = [
        "Ubuntu"
        "UbuntuMono"
      ];
    })
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          font-antialiasing = "rgba";
          font-name = "Ubuntu 11";
          document-font-name = "FreeSans 11";
          monospace-font-name = "UbuntuMono Nerd Font Regular 13";
        };
        "org/gnome/desktop/wm/preferences" = {
          titlebar-font = "Ubuntu Bold 11";
        };
      };
    }
  ];
}
