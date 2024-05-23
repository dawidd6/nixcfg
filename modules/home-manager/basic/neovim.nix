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
      lualine.enable = true;
      gitblame.enable = true;
      gitsigns.enable = true;
      mini.enable = true;
      mini.modules = {
        animate = {};
        basics = {};
        pairs = {};
        trailspace = {};
      };
    };
    extraPlugins = [
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
  };
}
