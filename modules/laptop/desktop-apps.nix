{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    krita
    libreoffice
    lutris
    mission-center
    pavucontrol
    remmina
    signal-desktop
    spotify
    vscode
  ];
}
