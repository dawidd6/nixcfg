{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

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
      alpha = {
        enable = true;
        theme = "startify";
      };
      barbecue.enable = true;
      bufferline.enable = true;
      cmp = {
        enable = true;
        settings = {
          sources = [
            {
              name = "buffer";
            }
            {
              name = "nvim_lsp";
            }
            {
              name = "path";
            }
          ];
          mapping = {
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
            "<Enter>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
      git-conflict.enable = true;
      gitsigns.enable = true;
      guess-indent.enable = true;
      lsp = {
        enable = true;
        servers = {
          ansiblels = {
            enable = true;
          };
          bashls = {
            enable = true;
          };
          dartls = {
            enable = true;
          };
          gopls = {
            enable = true;
          };
          nixd = {
            enable = true;
          };
          rubocop = {
            enable = true;
          };
          ruby_lsp = {
            enable = true;
          };
          ruff = {
            enable = true;
          };
        };
      };
      lualine.enable = true;
      noice.enable = true;
      nvim-autopairs.enable = true;
      rainbow-delimiters.enable = true;
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      trim.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };
  };
}
