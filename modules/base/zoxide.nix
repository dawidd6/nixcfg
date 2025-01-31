{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.zoxide ];

  programs.fish.interactiveShellInit = ''
    ${pkgs.zoxide}/bin/zoxide init fish --cmd=cd | source
  '';
}
