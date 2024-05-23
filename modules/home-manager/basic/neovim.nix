{
  pkgs,
  inputs,
  ...
}: {
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
    # TODO: after 24.05
    colorscheme = "vscode";
    #colorschemes.vscode.package = pkgs.unstable.vimPlugins.vscode-nvim;
    #colorschemes.vscode.enable = true;
    plugins = {
      bufferline.enable = true;
      gitsigns.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          nil_ls.enable = true;
        };
      };
      lspkind.enable = true;
      lualine.enable = true;
      noice.enable = true;
      nvim-autopairs.enable = true;
      nvim-cmp = {
        enable = true;
        sources = [
          {name = "buffer";}
          {name = "cmdline";}
          {name = "nvim_lsp";}
          {name = "path";}
        ];
      };
      which-key.enable = true;
    };
    extraPlugins = [
      {
        # TODO: switch to indent-o-matic after 24.05
        plugin = pkgs.vimPlugins.guess-indent-nvim;
        config = ''
          lua << EOF
          require('guess-indent').setup()
          EOF
        '';
      }
      {
        # TODO: https://github.com/nix-community/nixvim/issues/1553
        plugin = pkgs.vimPlugins.git-conflict-nvim;
        config = ''
          lua << EOF
          require('git-conflict').setup()
          EOF
        '';
      }
      {
        # TODO: replace with module after 24.05
        plugin = pkgs.unstable.vimPlugins.vscode-nvim;
        config = ''
          lua << EOF
          require('vscode').setup()
          EOF
        '';
      }
    ];
    keymaps = [
      {
        mode = ["n"];
        key = ".";
        action = ":bn<CR>";
        options = {
          desc = "Next buffer";
        };
      }
      {
        mode = ["n"];
        key = ",";
        action = ":bp<CR>";
        options = {
          desc = "Previous buffer";
        };
      }
      {
        mode = ["n" "v"];
        key = "x";
        action = "\"_x";
        options = {
          desc = "Delete character, don't cut";
        };
      }
      {
        mode = ["n" "v"];
        key = "X";
        action = "\"_X";
        options = {
          desc = "Delete character, don't cut";
        };
      }
      {
        mode = ["v"];
        key = "p";
        action = "\"_dP";
        options = {
          desc = "Don' copy on paste";
        };
      }
    ];
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
  };
}
