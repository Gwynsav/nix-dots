{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable  = true;
    extraPackages = with pkgs; [
      tree-sitter
    ];
    # Installs packer-nvim
    # First startup of NVIM may be messy,
    # execute PackerInstall and PackerUpdate.
    plugins = with pkgs.vimPlugins; [
      packer-nvim
    ];
  };
}
