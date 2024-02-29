_: {
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    signing.key = "172E9B0B";
    signing.signByDefault = true;
    userEmail = "dawidd0811@gmail.com";
    userName = "Dawid Dziurla";
    ignores = [
      ".direnv"
      ".idea"
      "*.iml"
      "result"
      ".vscode"
    ];
    includes = [
      {
        path = "~/.config/git/nokia";
        condition = "gitdir:~/ghorg/brcloud/**";
      }
    ];
    aliases = {
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
    extraConfig = {
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
  };
}
