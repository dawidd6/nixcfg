{ pkgs, ... }:
{
  programs.gnome-shell.enable = true;
  programs.gnome-shell.extensions = with pkgs.gnomeExtensions; [
    { package = appindicator; }
  ];
}
