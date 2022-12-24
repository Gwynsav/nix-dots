{ pkgs, colors, ... }:

{
  programs.zathura = {
    enable  = true;
    options = import ./colors.nix { inherit colors; };
  };
}
