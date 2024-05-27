{pkgs, ...}: {
  home.sessionVariables = {
    ELECTRON_TRASH = "gvfs-trash";
    # TODO: remove this workaround
    __HM_SESS_VARS_SOURCED = "";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "ls --color=always";
      rm = "trash";
      ssh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
      hub = "gh";
    };
    shellAbbrs = {
      e = "exit";
      more = "less";
      sl = "ls";
      add = "sudo apt install";
      purge = "sudo apt remove --purge";
      autopurge = "sudo apt autoremove --purge";
      update = "sudo apt update";
      upgrade = "sudo apt full-upgrade";
      search = "apt search";
      clean = "sudo apt clean && sudo apt autoclean";
      outdated = "apt list --upgradable";
      belongs = "apt-file search";
      contents = "apt-file list";
      show = "apt show";
      list = "dpkg -l";
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
      ghm = "git checkout (git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@origin/@@')";
      gb = "git branch -a";
      gf = "git fetch";
      gp = "git push";
      gfo = "git fetch origin";
      gpo = "git push origin -u";
      suspend = "systemctl suspend";
      clip = "xsel --clipboard";
      mic-test = "arecord -f cd - | aplay -";
      docker = "podman";
      d = "podman";
      p = "podman";
      hm = "home-manager";
    };
    shellInit = ''
      set fish_color_command green
      set fish_color_param normal
      set fish_color_error red --bold
      set fish_color_normal normal
      set fish_color_comment brblack
      set fish_color_quote yellow

      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source

      # TODO: workaround for duplicating PATH entries
      fish_add_path "$HOME/nix/scripts"
    '';
  };
}
