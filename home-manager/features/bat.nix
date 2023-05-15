{ inputs, config, pkgs, ... }: {
  programs.bat.enable = true;
  programs.bat.config = {
    pager = "less -FR";
    theme = "TwoDark";
  };
}
