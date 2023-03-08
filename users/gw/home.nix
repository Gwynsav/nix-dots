# -------------------------------- #
# -- Home Manager Configuration -- #
# -------------------------------- #

{ config, pkgs, lib, ... }:

let
  # Colorscheme
  colors = import ../common/theme/fullerene.nix {};
in

{
  # Program Configurations
  # ----------------------
  imports = [
    ( import ../common                         { inherit config pkgs lib colors; } )
    
    # Terminal Emulators
    # ( import ../common/config/terms/alacritty  { inherit colors; } )
    # ( import ../common/config/terms/kitty      { inherit colors; } )
    ( import ../common/config/terms/tym        { inherit pkgs colors; } )
    # ( import ../common/config/terms/wezterm    { inherit colors; } )

    # Terminal Shells
    ( import ../common/config/shell/hilbish    { inherit pkgs; } )
    # ( import ../common/config/shell/zsh        { inherit config; } )

    # Text Editors
    # ( import ../common/config/shell/nvim       { inherit pkgs colors; } )
    ( import ../common/config/editor/emacs     { inherit pkgs colors; } )

    # Browsers
    ( import ../common/config/browser/firefox  { inherit pkgs colors; } )
    ( import ../common/config/browser/nyxt     { inherit pkgs; } )
    
  ];
  # xdg.configFile.awesome.source = ../common/config/awesome;

  # GTK Configuration
  # -----------------
  gtk = {
    enable     = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    theme.name = "Catppuccin-Macchiato-Standard-Yellow-Dark";
    iconTheme  = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
