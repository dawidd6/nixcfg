{
  inputs,
  mkModule,
  ...
}:
mkModule {
  onNixos = {
    imports = [
      inputs.nixvim.nixosModules.nixvim
    ];
  };

  onHome = {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];
  };

  onAny = {
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
  };
}
