{ pkgs, ... }:

{
  programs.neovim = {
    enable     = true;
    extraPackages = with pkgs; [
      tree-sitter
      vimPlugins.packer-nvim
    ];
    viAlias       = true;
    vimAlias      = true;
  };
}
