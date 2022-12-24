{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable     = true;
    extraPackages = with pkgs; [
      tree-sitter
      vimPlugins.packer-nvim
    ];
  };
}
