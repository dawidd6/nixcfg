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
      # Completion
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      lspkind-nvim
      nvim-cmp
      nvim-lspconfig
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

        -- Completion
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        cmp.setup({
          formatting = {
            format = lspkind.cmp_format({
              mode = 'symbol',
              maxwidth = 50,
              ellipsis_char = '...',
              show_labelDetails = true,
            })
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
          }, {
            { name = 'path' },
          }, {
            { name = 'buffer' },
          })
        })
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          }),
          matching = { disallow_symbol_nonprefix_matching = false }
        })
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")["nil_ls"].setup {
          capabilities = capabilities
        }

        -- Convenience
        require("guess-indent").setup()
        require("nvim-autopairs").setup()
        require("trim").setup({
          trim_on_write = false,
          highlight = true
        })
        require("which-key").setup()

        -- Colorscheme
        require("vscode").setup()
        vim.cmd.colorscheme "vscode"
      end
    '';
  };
}
