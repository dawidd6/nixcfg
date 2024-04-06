{pkgs, ...}: {
  home.packages = with pkgs; [
    element-desktop
    filezilla
    fritzing
    gimp
    gnome.gnome-tweaks
    google-chrome
    gpick
    gscan2pdf
    inkscape
    keepassxc
    krita
    libreoffice
    pavucontrol
    signal-desktop
    spotify
    virt-manager
    vscode
  ];

  services.copyq.enable = true;

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "google-chrome.desktop"
        "spotify.desktop"
        "code.desktop"
        "virt-manager.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
      ];
    };
    "org/virt-manager/virt-manager" = {
      system-tray = true;
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
