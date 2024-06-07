{pkgs, ...}: {
  home.packages = with pkgs; [
    element-desktop
    filezilla
    firefox
    fritzing
    gimp
    gnome.gnome-boxes
    gnome.dconf-editor
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
    yubioath-flutter
  ];
}
