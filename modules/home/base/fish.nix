{
  pkgs,
  ...
}:
{
  programs.fish = {
    enable = true;
    generateCompletions = false;
    functions = {
      hub = {
        body = "command op plugin run -- gh $argv";
        wraps = "gh";
      };
    };
    shellAbbrs = {
      e = "exit";
      g = "git";
      ga = "git add";
      gc = "git commit -m";
      gca = "git commit --amend --no-edit";
      gcae = "git commit --amend --edit";
      gs = "git status -u";
      gt = "git tag";
      gd = "git diff";
      gdc = "git diff --cached";
      gh = "git checkout";
      gb = "git branch -a";
      gf = "git fetch";
      gp = "git push";
      gfo = "git fetch origin";
      gpo = "git push origin -u";
      clip = "xsel --clipboard";
      mic-test = "arecord -f cd - | aplay -";
      p = "podman";
      rm = "trash";
      ssh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
    };
    interactiveShellInit = ''
      set fish_color_command green
      set fish_color_param normal
      set fish_color_error red --bold
      set fish_color_normal normal
      set fish_color_comment brblack
      set fish_color_quote yellow

      # TODO: use module when it's ready
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source

      ${pkgs.carapace}/bin/carapace nix-build fish | source
      ${pkgs.carapace}/bin/carapace nix-instantiate fish | source
      ${pkgs.carapace}/bin/carapace nix-shell fish | source
      ${pkgs.carapace}/bin/carapace nixos-rebuild fish | source
    '';
  };
}
