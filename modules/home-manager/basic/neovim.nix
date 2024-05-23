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
      vscode-nvim
      # SCM helpers
      git-blame-nvim
      git-conflict-nvim
      gitsigns-nvim
      # Misc
      mini-nvim
    ];
    extraLuaConfig = ''
      require('bufferline').setup()
      require('lualine').setup()
      require('vscode').setup()
      require('gitblame').setup()
      require('git-conflict').setup()
      require('gitsigns').setup()
      require('mini.animate').setup()
      require('mini.basics').setup()
      require('mini.pairs').setup()
      require('mini.trailspace').setup()
    '';
    extraConfig = ''
      colorscheme vscode
      set clipboard=unnamedplus
      " Key bindings
      nnoremap . :bn<CR>
      nnoremap , :bp<CR>
      " Delete char, don't cut
      nnoremap x "_x
      nnoremap X "_X
      vnoremap x "_x
      vnoremap X "_X
      " Don't copy on paste
      vnoremap p "_dP
    '';
  };
}
