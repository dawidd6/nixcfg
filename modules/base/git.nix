{ pkgs, mkModule, ... }:
let
  ignores = ''
    .direnv
    .idea
    *.iml
    result
    .vscode
  '';
  settings = {
    user = {
      email = "dawidd0811@gmail.com";
      name = "Dawid Dziurla";
      signingKey = "~/.ssh/id_ed25519.pub";
    };
    alias = {
      lg = "log --graph --pretty=format:'%Cred%h%Creset %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset %s %C(yellow)%d%Creset'";
      ls = "ls-tree -r --name-only HEAD";
      unadd = "restore --staged";
    };
    commit.gpgSign = true;
    tag.gpgSign = true;
    format.pretty = "fuller";
    gpg.format = "ssh";
    core.excludesfile = "${pkgs.writeText "gitignore" ignores}";
    url."git@github.com:".pushInsteadOf = "https://github.com/";
    includeIf."gitdir:~/ghorg/brcloud/**".path = "~/.config/git/nokia";
  };
in
mkModule {
  onNixos = {
    programs.git.config = settings;
  };

  onHome = {
    programs.git.extraConfig = settings;
  };

  onAny = {
    programs.git.enable = true;

    programs.fish.shellAbbrs = {
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
    };
  };
}
