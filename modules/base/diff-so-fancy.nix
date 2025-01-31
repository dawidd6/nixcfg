{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.diff-so-fancy ];

  programs.git.config = {

    core = {
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };

    diff-so-fancy = {
      changeHunkIndicators = true;
      markEmptyLines = true;
      stripLeadingSymbols = true;
      useUnicodeRuler = true;
    };

    interactive = {
      diffFilter = "diff-so-fancy --patch";
    };
  };
}
