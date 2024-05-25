{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.unstable.vimPlugins; [
      # Appearance
      bufferline-nvim
      lualine-nvim
      noice-nvim
      # SCM
      git-conflict-nvim
      gitsigns-nvim
      # Convenience
      guess-indent-nvim
      nvim-autopairs
      trim-nvim
      which-key-nvim
      # Colorscheme
      vscode-nvim
    ];
    extraLuaConfig = ''
      vim.opt.clipboard = "unnamedplus"

      vim.keymap.set("n", ".", ":bn<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", ",", ":bp<CR>", { desc = "Previous buffer" })
      vim.keymap.set({"n","v"}, "x", "\"_x", { desc = "Don't cut character, just delete" })
      vim.keymap.set({"n","v"}, "X", "\"_X", { desc = "Don't cut character, just delete" })
      vim.keymap.set("v", "p", "\"_dP", { desc = "Don't copy on paste" })

      if not vim.g.vscode then
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

        -- Appearance
        require("bufferline").setup()
        require("lualine").setup()
        require("noice").setup()

        -- SCM
        require("git-conflict").setup()
        require("gitsigns").setup()

        -- Convenience
        require("guess-indent").setup()
        require("nvim-autopairs").setup()
        require("trim").setup({
          trim_on_write = false,
          highlight = true,
        })
        require("which-key").setup()

        -- Colorscheme
        require("vscode").setup()
        vim.cmd.colorscheme "vscode"
      end
    '';
  };
}
