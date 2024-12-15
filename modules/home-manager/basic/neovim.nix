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
      bufferline.enable = true;
      coq-nvim = {
        enable = true;
        installArtifacts = true;
        settings.auto_start = "shut-up";
      };
      cursorline.enable = true;
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
}
