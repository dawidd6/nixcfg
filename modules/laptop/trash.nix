{
  pkgs,
  ...
}:

{
  environment.systemPackages = [ pkgs.trash-cli ];

  programs.fish.shellAbbrs.rm = "trash";
}
