{
  pkgs,
  inputs,
  config,
  lib,
  userName,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-index-database.hmModules.nix-index
  ];

  systemd.user.services.onedrive = {
    Unit.Description = "Onedrive sync service";
    Install.WantedBy = [ "default.target" ];
    Service = {
      Environment = [
        "Environment=HTTP_PROXY=http://10.144.1.10:8080"
        "Environment=HTTPS_PROXY=http://10.144.1.10:8080"
      ];
      Type = "simple";
      ExecStart = ''
        ${pkgs.onedrive}/bin/onedrive --monitor --confdir=%h/.config/onedrive
      '';
      Restart = "on-failure";
      RestartSec = 3;
      RestartPreventExitStatus = 3;
    };
  };

  home.packages = with pkgs; [
    git-extras
    podman
    podman-compose
    ack
    ansible
    ansible-lint
    btop
    cloc
    cpio
    curl
    carapace
    diffoscopeMinimal
    distrobox
    dos2unix
    file
    fx
    gh
    ghorg
    glab
    gnumake
    htop
    hydra-check
    onedrive
    ipcalc
    jq
    lm_sensors
    inputs.self.packages.${pkgs.system}.scripts
    ncdu
    nix-diff
    nix-init
    nix-inspect
    nix-tree
    nix-update
    nixd
    nixfmt-rfc-style
    nixos-shell
    nixpkgs-review
    nmap
    nodejs
    nurl
    nvd
    python3
    ripgrep
    ruby
    shellcheck
    sshpass
    strace
    tealdeer
    tmux
    trash-cli
    tree
    unzip
    wget
    xsel
    yubikey-manager
  ];

  nix.package = pkgs.nix;
  nix.settings.warn-dirty = false;
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    config.allowUnfree = true;
  };

  xdg.configFile = {
    "nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';
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
    "containers/containers.conf".text = ''
      [network]
      default_subnet="172.16.10.0/24"
      default_subnet_pools = [
        {"base" = "172.16.11.0/24", "size" = 24},
        {"base" = "172.16.12.0/24", "size" = 24},
        {"base" = "172.16.13.0/24", "size" = 24},
        {"base" = "172.16.14.0/24", "size" = 24},
        {"base" = "172.16.15.0/24", "size" = 24},
        {"base" = "172.16.16.0/24", "size" = 24},
        {"base" = "172.16.17.0/24", "size" = 24},
        {"base" = "172.16.18.0/24", "size" = 24},
        {"base" = "172.16.19.0/24", "size" = 24},
        {"base" = "172.16.20.0/24", "size" = 24},
      ]
    '';
  };

  manual.manpages.enable = false;

  programs.home-manager.enable = true;
  programs.fzf.enable = true;
  programs.less.enable = true;

  programs.zoxide = {
    enable = true;
    options = [ "--cmd=cd" ];
  };

  programs.nixvim = {
    enable = true;
    enableMan = false;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    clipboard.register = "unnamedplus";
    colorschemes.vscode.enable = true;
    opts = {
      expandtab = true;
      gdefault = true;
      ignorecase = true;
      number = true;
      shiftwidth = 4;
      showmatch = true;
      showtabline = 2;
      smartcase = true;
      smartindent = true;
      softtabstop = 4;
      swapfile = false;
      tabstop = 4;
      termguicolors = true;
      visualbell = true;
      writebackup = false;
    };
    keymaps = [
      {
        action = "\"_x";
        key = "x";
        options = {
          silent = true;
        };
        mode = [
          "n"
          "v"
        ];
      }
      {
        action = "\"_X";
        key = "X";
        options = {
          silent = true;
        };
        mode = [
          "n"
          "v"
        ];
      }
      {
        action = "\"_dP";
        key = "p";
        options = {
          silent = true;
        };
        mode = [
          "v"
        ];
      }
    ];
    plugins = {
      bufferline.enable = true;
      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };
      git-conflict.enable = true;
      gitsigns.enable = true;
      guess-indent.enable = true;
      lualine.enable = true;
      noice.enable = true;
      nvim-autopairs.enable = true;
      startify.enable = true;
      trim.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Visual Studio Dark+";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        warn_timeout = "15m";
        hide_env_diff = true;
      };
    };
  };

  programs.eza.enable = true;
  programs.eza.extraOptions = [
    "--group-directories-first"
    "--group"
    "--header"
    "--time-style=long-iso"
  ];

  programs.fish = {
    enable = true;
    generateCompletions = false;
    shellAliases = {
      rm = "trash";
      ssh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
      hub = "gh";
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
      p = "podman";
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
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 5000;
      add_newline = false;
      line_break = {
        disabled = true;
      };
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[➜](bold red) ";
      };
      status = {
        disabled = false;
        format = "[$status]($style) ";
      };
      nix_shell = {
        heuristic = true;
      };
    };
  };

  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    userEmail = "dawidd0811@gmail.com";
    userName = "Dawid Dziurla";
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
      gpgPath = "";
    };
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
      gpg.format = "ssh";
      format.pretty = "fuller";
      url."git@github.com:".pushInsteadOf = "https://github.com/";
    };
  };

  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    if [[ -v oldGenPath ]]; then
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
    fi
  '';

  # TODO: https://github.com/nix-community/home-manager/issues/5481
  home.activation.batCache = lib.mkForce "";

  home.sessionVariables = {
    ELECTRON_TRASH = "gvfs-trash";
    # TODO: remove this workaround
    __HM_SESS_VARS_SOURCED = "";
  };

  home.username = userName;
  home.homeDirectory = "/home/${userName}";
  home.stateVersion = "22.11";
}
