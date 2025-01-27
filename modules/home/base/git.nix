_: {
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    signing.key = "~/.ssh/id_ed25519.pub";
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
      unadd = "restore --staged";
      ls = "ls-tree -r --name-only HEAD";
    };
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      format = {
        pretty = "fuller";
      };
      url = {
        "git@github.com:dawidd6" = {
          pushInsteadOf = "https://github.com/dawidd6";
        };
      };
    };
  };
}
