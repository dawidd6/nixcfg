{ pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      filezilla
      firefox
      fritzing
      gimp
      gnome.dconf-editor
      gnome.gnome-boxes
      gnome.gnome-power-manager
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
