{ inputs, config, pkgs, ... }: {
  programs.git.enable = true;
  programs.git.diff-so-fancy.enable = true;
  programs.git.signing.key = "172E9B0B";
  programs.git.signing.signByDefault = true;
  programs.git.userEmail = "dawidd0811@gmail.com";
  programs.git.userName = "Dawid Dziurla";
  programs.git.ignores = [
    ".idea"
    "*.iml"
    ".vscode"
  ];
  programs.git.includes = [
    {
      path = "~/.config/git/nokia";
      condition = "gitdir:~/ghorg/brcloud/**";
    }
  ];
  programs.git.aliases = {
    lg = "log --graph --pretty=format:'%Cred%h%Creset %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset %s %C(yellow)%d%Creset'";
    c = "commit -m";
    s = "status";
    d = "diff";
    dc = "diff --cached";
    unadd = "restore --staged";
    ls = "ls-tree -r --name-only HEAD";
    amend = "commit -S --amend --no-edit";
    amend-edit = "commit -S --amend --edit";
    cleanout = "!read -p '==> Clean?' var && git clean -fd && git checkout -- .";
    fix-commit-rebase = "!f(){git commit --fixup $1 && git rebase -i --autosquash $1~1}; f";
    prune-local-branches = "!git branch --merged master | grep -v '^[ *]*master$' | xargs -r git branch -d";
  };
  programs.git.extraConfig = {
    format = {
      pretty = "fuller";
    };
    url = {
      "git@github.com:dawidd6" = {
        pushInsteadOf = "https://github.com/dawidd6";
      };
      "git@github.com:Homebrew" = {
        pushInsteadOf = "https://github.com/Homebrew";
      };
    };
  };
}
