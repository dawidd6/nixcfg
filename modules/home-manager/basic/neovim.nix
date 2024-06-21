{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.unstable.vimPlugins; [
      # Appearance
      {
        plugin = bufferline-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! bufferline.nvim")
          require("bufferline").setup()
        '';
      }
      {
        plugin = lualine-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! lualine.nvim")
          require("lualine").setup()
        '';
      }
      {
        plugin = noice-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! noice.nvim")
          require("noice").setup()
        '';
      }
      # SCM
      {
        plugin = git-conflict-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! git-conflict.nvim")
          require("git-conflict").setup()
        '';
      }
      {
        plugin = gitsigns-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! gitsigns.nvim")
          require("gitsigns").setup()
        '';
      }
      # Convenience
      {
        plugin = guess-indent-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! guess-indent.nvim")
          require("guess-indent").setup()
        '';
      }
      {
        plugin = nvim-autopairs;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! nvim-autopairs")
          require("nvim-autopairs").setup()
        '';
      }
      {
        plugin = trim-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! trim.nvim")
          require("trim").setup({
            trim_on_write = false,
            highlight = true,
          })
        '';
      }
      {
        plugin = which-key-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! which-key.nvim")
          require("which-key").setup()
        '';
      }
      # Colorscheme
      {
        plugin = vscode-nvim;
        optional = true;
        type = "lua";
        config = ''
          vim.cmd("packadd! vscode.nvim")
          require("vscode").setup()
          vim.cmd.colorscheme "vscode"
        '';
      }
    ];
    extraLuaConfig = ''
      vim.keymap.set({"n","v"}, "x", "\"_x", { desc = "Don't cut character, just delete" })
      vim.keymap.set({"n","v"}, "X", "\"_X", { desc = "Don't cut character, just delete" })
      vim.keymap.set("v", "p", "\"_dP", { desc = "Don't copy on paste" })
      vim.opt.clipboard = "unnamedplus"

      if vim.g.vscode then
        return
      end

      vim.keymap.set("n", ".", ":bn<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", ",", ":bp<CR>", { desc = "Previous buffer" })
      vim.opt.expandtab = true
      vim.opt.gdefault = true
      vim.opt.ignorecase = true
      vim.opt.number = true
      vim.opt.shiftwidth = 4
      vim.opt.showmatch = true
      vim.opt.showtabline = 2
      vim.opt.smartcase = true
      vim.opt.smartindent = true
      vim.opt.softtabstop = 4
      vim.opt.swapfile = false
      vim.opt.tabstop = 4
      vim.opt.termguicolors = true
      vim.opt.visualbell = true
      vim.opt.writebackup = false
    '';
  };
}
