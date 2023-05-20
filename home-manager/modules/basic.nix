{
  inputs,
  pkgs,
  lib,
  username,
  ...
}: let
  my-scripts = pkgs.buildEnv {
    name = "my-scripts";
    paths = [../../scripts];
    extraPrefix = "/bin";
  };
in {
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
    sessionVariables = {
      ELECTRON_TRASH = "gvfs-trash";
    };
    packages = with pkgs; [
      ansible
      ansible-lint
      btop
      cpio
      curl
      diffoscopeMinimal
      distrobox
      dos2unix
      gh
      ghorg
      glab
      htop
      ipcalc
      jq
      lazygit
      lm_sensors
      my-scripts
      ncdu
      nmap
      podman
      ruby
      sshpass
      strace
      tealdeer
      trash-cli
      tree
      xsel
    ];
  };

  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  xdg.configFile = {
    "containers/policy.json".text = ''
      {"default":[{"type":"insecureAcceptAnything"}]}
    '';
    "containers/registries.conf".text = ''
      unqualified-search-registries=["docker.io"]
    '';
    "containers/storage.conf".text = ''
      [storage]
      driver = "overlay"
    '';
  };

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "TwoDark";
      };
    };
    fish = {
      enable = true;
      shellAliases = {
        sudo = "sudo -E env \"PATH=$PATH\"";
        ls = "ls --color=always";
        rm = "trash";
        dotfiles = "git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
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
        hms = "home-manager switch --flake $HOME/nix#$USER";
        hmb = "home-manager build --flake $HOME/nix#$USER";
        hmd = "home-manager build --flake $HOME/nix#$USER && nix store diff-closures /nix/var/nix/profiles/per-user/$USER/home-manager $HOME/nix/result";
      };
      interactiveShellInit = ''
        set fish_color_command green
        set fish_color_param normal
        set fish_color_error red --bold
        set fish_color_normal normal
        set fish_color_comment brblack
        set fish_color_quote yellow
      '';
    };
    fzf.enable = true;
    git = {
      enable = true;
      diff-so-fancy.enable = true;
      signing.key = "172E9B0B";
      signing.signByDefault = true;
      userEmail = "dawidd0811@gmail.com";
      userName = "Dawid Dziurla";
      ignores = [
        ".idea"
        "*.iml"
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
    gpg.enable = true;
    home-manager.enable = true;
    less.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-fugitive
        vim-startify
        vim-better-whitespace
        lightline-vim
        lightline-bufferline
        vim-gitgutter
        material-vim
        conflict-marker-vim
        vim-nix
      ];
      extraConfig = ''
        " Plugins
        let g:lightline = { 'colorscheme': 'material' }
        let g:lightline.tabline          = {'left': [['buffers']], 'right': [[]]}
        let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
        let g:lightline.component_type   = {'buffers': 'tabsel'}
        let g:gitgutter_enabled=1
        let g:material_theme_style='darker'
        let g:material_terminal_italics=1
        let g:conflict_marker_begin = '^<<<<<<< .*$'
        let g:conflict_marker_end   = '^>>>>>>> .*$'
        " Indent
        set autoindent
        set smartindent
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab
        set smarttab
        " Search
        set ignorecase
        set incsearch
        set hlsearch
        set showmatch
        set gdefault
        " Appearance
        syntax on
        colorscheme material
        set background=dark
        set number
        set wildmenu
        set termguicolors
        set laststatus=2
        set showcmd
        set showmode
        set guicursor=
        " Timing
        set updatetime=100
        set ttimeoutlen=10
        " Buffers
        set hidden
        set showtabline=2
        " Backups
        set noswapfile
        set nobackup
        set nowritebackup
        " Behaviour
        filetype plugin on
        set nocompatible
        set backspace=indent,eol,start
        set clipboard=unnamed,unnamedplus
        set visualbell
        set autoread
        set encoding=utf8
        set completeopt-=preview
        set nofixendofline
        " Change cursor based on mode
        set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
        highlight Cursor gui=reverse
        " Key bindings
        nnoremap . :bn<CR>
        nnoremap , :bp<CR>
        nnoremap <C-c> :e ++enc=cp1250<CR>
        nnoremap <C-u> :e ++enc=utf-8<CR>
        " Trim whitespace
        nnoremap <F12> :%s/\s\+$//e<CR>
        " YAML
        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
        " Ruby
        autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
        " Jenkinsfile
        au BufNewFile,BufRead Jenkinsfile setf groovy
        " Delete, don't cut
        nnoremap x "_x
        nnoremap X "_X
        " Don't copy on paste
        vnoremap p "_dP
      '';
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[➜](bold red) ";
        };
        line_break = {
          disabled = true;
        };
        status = {
          disabled = false;
          format = "[$status]($style) ";
        };
      };
    };
    zoxide = {
      enable = true;
      options = ["--cmd=cd"];
    };
  };
}
