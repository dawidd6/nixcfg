{ pkgs, mkModule, ... }:
let
  settings = {
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
in
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.diff-so-fancy ];

    programs.git.config = settings;
  };

  onHome = {
    home.packages = [ pkgs.diff-so-fancy ];

    programs.git.extraConfig = settings;
  };
}
