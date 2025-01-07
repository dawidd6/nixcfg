{ pkgsUnstable, ... }:
{
  home.packages = with pkgsUnstable; [
    dconf-editor
    eyedropper
    filezilla
    firefox
    fritzing
    gimp
    gnome-boxes
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
  ];

  services.copyq.enable = true;
}
