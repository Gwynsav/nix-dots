# ------------------ #
# -- nyxt browser -- #
# ------------------ #
{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.unstable.nyxt ];
  #   file = {
  #     ".config/hilbish/init.lua" = {
  #       text = import ./config.nix { }; 
  #     };
  #   };
  };
}
