{ inputs, lib, config, pkgs, ... }: {
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-fugitive
    vim-startify
    vim-better-whitespace
    lightline-vim
    lightline-bufferline
    vim-gitgutter
    material-vim
    conflict-marker-vim
    vim-nix
  ];
  programs.neovim.extraConfig = lib.readFile ./init.vim;
}
