{
  lib,
  inputs,
  outputs,
  pkgs,
  config,
  userName,
  ...
}@args:
let
  asGB = size: toString (size * 1024 * 1024 * 1024);
in
{
  # nix
  nix.package = lib.mkIf (!args ? osConfig) pkgs.nix;
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  nix.settings.nix-path = lib.mapAttrsToList (name: _: "${name}=flake:${name}") inputs;
  nix.settings.flake-registry = "";
  nix.settings.warn-dirty = false;
  nix.settings.min-free = asGB 10;
  nix.settings.max-free = asGB 50;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.extra-substituters = [ "https://dawidd6.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="
  ];

  # nixpkgs-unstable
  #_module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
  #  inherit (pkgs) system;
  #  config.allowUnfree = true;
  #  overlays = [ outputs.overlays.default ];
  #};

  # nixpkgs
  nixpkgs = lib.mkIf (!args ? osConfig) {
    config.allowUnfree = true;
    overlays = [ outputs.overlays.default ];
  };
  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  # home
  programs.home-manager.enable = true;
  manual.manpages.enable = false;
  news.display = "silent";
  home.stateVersion = lib.mkIf (args ? osConfig) args.osConfig.system.stateVersion;
  home.username = userName;
  home.homeDirectory = "/home/${userName}";
  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    if [[ -v oldGenPath ]]; then
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
    fi
  '';
  home.sessionVariables = {
    ELECTRON_TRASH = "gvfs-trash";
    __HM_SESS_VARS_SOURCED = "";
  };

  # neovim
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
      rainbow-delimiters.enable = true;
      startify.enable = true;
      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };
      trim.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };
  };

  # starship
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

  # fish
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
      mic-test = "arecord -f cd - | aplay -";
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
      ${pkgs.carapace}/bin/carapace nixos-rebuild fish | source
    '';
  };

  # bat
  # TODO: https://github.com/nix-community/home-manager/issues/5481
  home.activation.batCache = lib.mkForce "";
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Visual Studio Dark+";
    };
  };

  # eza
  programs.eza.enable = true;
  programs.eza.extraOptions = [
    "--group-directories-first"
    "--group"
    "--header"
    "--time-style=long-iso"
  ];

  # zoxide
  programs.zoxide = {
    enable = true;
    options = [ "--cmd=cd" ];
  };

  # fzf
  programs.fzf.enable = true;

  # less
  programs.less.enable = true;

  # direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config = {
    global = {
      warn_timeout = "15m";
      hide_env_diff = true;
    };
  };

  # gpg
  programs.gpg.enable = true;
  programs.gpg.scdaemonSettings = {
    disable-ccid = true;
  };
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = false;
  services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;

  # git
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
      unadd = "restore --staged";
      ls = "ls-tree -r --name-only HEAD";
    };
    extraConfig = {
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

  # podman
  xdg.configFile."containers/policy.json".text = ''
    {"default":[{"type":"insecureAcceptAnything"}]}
  '';
  xdg.configFile."containers/registries.conf".text = ''
    unqualified-search-registries=["docker.io"]
  '';
  xdg.configFile."containers/storage.conf".text = ''
    [storage]
    driver = "overlay"
  '';
  xdg.configFile."containers/containers.conf".text = ''
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

  # tools
  home.packages = with pkgs; [
    ack
    ansible
    ansible-lint
    btop
    carapace
    cloc
    cpio
    curl
    diffoscopeMinimal
    distrobox
    dos2unix
    file
    fx
    gh
    ghorg
    git-extras
    glab
    gnumake
    htop
    hydra-check
    ipcalc
    jq
    lm_sensors
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
    outputs.packages.${system}.scripts
    podman
    podman-compose
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
}
