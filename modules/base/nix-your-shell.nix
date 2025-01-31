{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.nix-your-shell ];

  programs.fish.interactiveShellInit = ''
    ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
  '';
}
