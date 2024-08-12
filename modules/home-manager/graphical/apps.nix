{ pkgs, ... }:
{
  home.packages =
    (with pkgs; [
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
      lutris
      mission-center
      pavucontrol
      signal-desktop
      spotify
      virt-manager
      yubioath-flutter
    ])
    ++ (with pkgs.unstable; [ vscode ]);
}
