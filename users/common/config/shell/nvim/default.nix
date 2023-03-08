{ pkgs, colors, ... }:

with colors; {
  programs.neovim = {
    enable        = true;
    package       = pkgs.neovim-nightly;

    plugins       = with pkgs.vimPlugins; [
      ## utils
      # basics
      packer-nvim
      nvim-treesitter
      vim-polyglot
      # commenting
      comment-nvim
      nvim-ts-context-commentstring
      # snippets
      vim-vsnip cmp-vsnip
      # completion
      nvim-cmp cmp-buffer cmp-path
      cmp-treesitter cmp-cmdline

      ## ui
      barbar-nvim
      lualine-nvim
      nvim-colorizer-lua
      nvim-tree-lua
      nvim-web-devicons

      ## colorschemes
      catppuccin-nvim
      everforest
      gruvbox-nvim
      tokyonight-nvim
    ];
    extraConfig   = import ./config.nix { inherit colors; };

    # Use as default editor.
    viAlias       = true;
    vimAlias      = true;
  };
}
